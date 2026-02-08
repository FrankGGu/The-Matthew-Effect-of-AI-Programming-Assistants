#include <vector>
#include <algorithm>
#include <map>
#include <set>

class BIT {
public:
    std::vector<int> tree;
    int size;

    BIT(int s) : size(s), tree(s + 1, 0) {}

    void update(int idx, int delta) {
        for (++idx; idx <= size; idx += idx & -idx) {
            tree[idx] += delta;
        }
    }

    int query(int idx) {
        int sum = 0;
        for (++idx; idx > 0; idx -= idx & -idx) {
            sum += tree[idx];
        }
        return sum;
    }
};

class Solution {
public:
    long long total_overall_inversions = 0;
    std::vector<int> all_values_raw;
    std::map<int, int> val_to_rank; // original value -> 0-indexed rank

    void collect_values(TreeNode* node) {
        if (!node) return;
        all_values_raw.push_back(node->val);
        collect_values(node->left);
        collect_values(node->right);
    }

    void coordinate_compress() {
        std::sort(all_values_raw.begin(), all_values_raw.end());
        all_values_raw.erase(std::unique(all_values_raw.begin(), all_values_raw.end()), all_values_raw.end());
        for (int i = 0; i < all_values_raw.size(); ++i) {
            val_to_rank[all_values_raw[i]] = i;
        }
    }

    // DFS function returns a pointer to a map representing frequency of compressed ranks
    // for the subtree rooted at 'node'. Uses small-to-large merging.
    std::map<int, int>* dfs(TreeNode* node) {
        if (!node) {
            return nullptr;
        }

        std::map<int, int>* left_map = dfs(node->left);
        std::map<int, int>* right_map = dfs(node->right);

        // Ensure left_map is the larger (or non-null) map
        if (left_map == nullptr) {
            left_map = right_map;
            right_map = nullptr;
        } else if (right_map != nullptr && left_map->size() < right_map->size()) {
            std::swap(left_map, right_map);
        }

        // If both children were null, create a new map for current node
        if (left_map == nullptr) {
            left_map = new std::map<int, int>();
        }

        long long inversions_for_this_subtree = 0;

        // Create a temporary BIT to represent elements in the current combined subtree
        // (starting with the larger child's elements, then merging smaller child, then root)
        BIT temp_bit(val_to_rank.size());

        // Populate BIT with elements from the larger child (left_map)
        for (auto const& [rank, count] : *left_map) {
            temp_bit.update(rank, count);
        }

        // Merge elements from the smaller child (right_map) into left_map and count inversions
        if (right_map != nullptr) {
            for (auto const& [rank_r, count_r] : *right_map) {
                // Inversions (x, rank_r) where x is in left_map and x > rank_r
                // Count elements in temp_bit (representing left_map) that are greater than rank_r
                inversions_for_this_subtree += (long long)count_r * (temp_bit.query(val_to_rank.size() - 1) - temp_bit.query(rank_r));

                // Add rank_r to temp_bit and left_map
                temp_bit.update(rank_r, count_r);
                (*left_map)[rank_r] += count_r;
            }
            delete right_map; // Clean up the smaller map
        }

        // Add current node's value (compressed rank) to the subtree's map and count inversions
        int root_rank = val_to_rank[node->val];

        // Inversions (root_rank, x) where x is already in temp_bit (i.e., from children) and root_rank > x
        // Count elements in temp_bit (representing merged children) that are less than root_rank
        inversions_for_this_subtree += temp_bit.query(root_rank - 1);

        // Add root_rank to temp_bit and left_map
        temp_bit.update(root_rank, 1);
        (*left_map)[root_rank]++;

        total_overall_inversions += inversions_for_this_subtree;

        return left_map;
    }

    long long subtreeInversionSum(TreeNode* root) {
        if (!root) return 0;

        // Step 1: Collect all values for coordinate compression
        collect_values(root);

        // Step 2: Coordinate compress the values
        coordinate_compress();

        // Step 3: Perform DFS with small-to-large merging and BIT for inversion counting
        std::map<int, int>* final_map = dfs(root);

        // Clean up the dynamically allocated map for the root's subtree
        if (final_map != nullptr) {
            delete final_map;
        }

        return total_overall_inversions;
    }
};
#include <vector>
#include <algorithm>
#include <tuple>

struct TrieNode {
    TrieNode* children[2];
    TrieNode() {
        children[0] = nullptr;
        children[1] = nullptr;
    }
};

class Trie {
private:
    TrieNode* root;
    const int MAX_BITS = 30; // Numbers up to 10^9 fit in 30 bits (0 to 29)

public:
    Trie() {
        root = new TrieNode();
    }

    // Inserts a number into the Trie
    void insert(int num) {
        TrieNode* curr = root;
        for (int i = MAX_BITS - 1; i >= 0; --i) {
            int bit = (num >> i) & 1;
            if (curr->children[bit] == nullptr) {
                curr->children[bit] = new TrieNode();
            }
            curr = curr->children[bit];
        }
    }

    // Queries the Trie for the maximum XOR sum with 'num'
    int query(int num) {
        TrieNode* curr = root;
        int maxXor = 0;
        for (int i = MAX_BITS - 1; i >= 0; --i) {
            int bit = (num >> i) & 1;
            // Try to find the opposite bit to maximize XOR
            if (curr->children[1 - bit] != nullptr) {
                maxXor |= (1 << i); // Set this bit in maxXor
                curr = curr->children[1 - bit];
            } else { // Must go with the same bit
                curr = curr->children[bit];
            }
        }
        return maxXor;
    }

    // Destructor to free memory
    ~Trie() {
        deleteNode(root);
    }

private:
    void deleteNode(TrieNode* node) {
        if (!node) return;
        deleteNode(node->children[0]);
        deleteNode(node->children[1]);
        delete node;
    }
};

class Solution {
public:
    std::vector<int> maximizeXor(std::vector<int>& nums, std::vector<std::vector<int>>& queries) {
        // Store queries with their original indices to reconstruct the answer order
        // Format: (mi, xi, original_index)
        std::vector<std::tuple<int, int, int>> indexedQueries;
        for (int i = 0; i < queries.size(); ++i) {
            indexedQueries.emplace_back(queries[i][1], queries[i][0], i);
        }

        // Sort nums in ascending order
        std::sort(nums.begin(), nums.end());

        // Sort queries based on mi in ascending order
        std::sort(indexedQueries.begin(), indexedQueries.end());

        std::vector<int> ans(queries.size());
        Trie trie;
        int num_idx = 0; // Pointer for iterating through the sorted nums array

        // Process queries in increasing order of mi
        for (const auto& query_tuple : indexedQueries) {
            int mi = std::get<0>(query_tuple);
            int xi = std::get<1>(query_tuple);
            int original_idx = std::get<2>(query_tuple);

            // Add all numbers from nums that are <= current mi to the Trie
            // Since both nums and queries are sorted, we add numbers incrementally
            while (num_idx < nums.size() && nums[num_idx] <= mi) {
                trie.insert(nums[num_idx]);
                num_idx++;
            }

            // If no numbers have been inserted into the Trie yet (i.e., all numbers in nums are > mi)
            // then no valid aj exists for this query.
            if (num_idx == 0) {
                ans[original_idx] = -1;
            } else {
                ans[original_idx] = trie.query(xi);
            }
        }

        return ans;
    }
};
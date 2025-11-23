#include <vector>
#include <map>
#include <set>
#include <limits> // For std::numeric_limits<long long>::min()

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    bool collect_info_dfs(TreeNode* node,
                          const std::map<int, TreeNode*>& initial_roots_map,
                          std::map<int, int>& in_degree,
                          std::set<int>& all_node_values) {
        if (!node) return true;

        if (all_node_values.count(node->val)) {
            return false;
        }
        all_node_values.insert(node->val);

        if (node->left) {
            if (initial_roots_map.count(node->left->val)) {
                in_degree[node->left->val]++;
            } else {
                if (!collect_info_dfs(node->left, initial_roots_map, in_degree, all_node_values)) {
                    return false;
                }
            }
        }
        if (node->right) {
            if (initial_roots_map.count(node->right->val)) {
                in_degree[node->right->val]++;
            } else {
                if (!collect_info_dfs(node->right, initial_roots_map, in_degree, all_node_values)) {
                    return false;
                }
            }
        }
        return true;
    }

    void merge_dfs(TreeNode* node, const std::map<int, TreeNode*>& initial_roots_map) {
        if (!node) return;

        if (node->left) {
            if (initial_roots_map.count(node->left->val)) {
                node->left = initial_roots_map.at(node->left->val);
            }
            merge_dfs(node->left, initial_roots_map);
        }
        if (node->right) {
            if (initial_roots_map.count(node->right->val)) {
                node->right = initial_roots_map.at(node->right->val);
            }
            merge_dfs(node->right, initial_roots_map);
        }
    }

    bool validate_bst_dfs(TreeNode* node, long long& prev_val, int& current_node_count) {
        if (!node) return true;

        if (!validate_bst_dfs(node->left, prev_val, current_node_count)) {
            return false;
        }

        if (node->val <= prev_val) {
            return false;
        }
        prev_val = node->val;
        current_node_count++;

        if (!validate_bst_dfs(node->right, prev_val, current_node_count)) {
            return false;
        }
        return true;
    }

    TreeNode* canMerge(std::vector<TreeNode*>& trees) {
        if (trees.empty()) {
            return nullptr;
        }

        std::map<int, TreeNode*> initial_roots_map;
        std::map<int, int> in_degree;
        std::set<int> all_node_values;

        for (TreeNode* tree : trees) {
            if (initial_roots_map.count(tree->val)) {
                return nullptr;
            }
            initial_roots_map[tree->val] = tree;
            in_degree[tree->val] = 0;
        }

        for (TreeNode* tree : trees) {
            if (!collect_info_dfs(tree, initial_roots_map, in_degree, all_node_values)) {
                return nullptr;
            }
        }
        int expected_total_nodes = all_node_values.size();

        TreeNode* final_root = nullptr;
        int root_candidate_count = 0;
        for (auto const& [val, ptr] : initial_roots_map) {
            if (in_degree[val] == 0) {
                final_root = ptr;
                root_candidate_count++;
            }
        }

        if (root_candidate_count != 1) {
            return nullptr;
        }

        merge_dfs(final_root, initial_roots_map);

        long long prev_val = std::numeric_limits<long long>::min();
        int merged_node_count = 0;
        if (!validate_bst_dfs(final_root, prev_val, merged_node_count)) {
            return nullptr;
        }

        if (merged_node_count != expected_total_nodes) {
            return nullptr;
        }

        return final_root;
    }
};
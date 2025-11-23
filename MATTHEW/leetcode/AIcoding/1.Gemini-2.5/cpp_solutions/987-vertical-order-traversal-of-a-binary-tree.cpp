#include <vector>
#include <map>
#include <queue>
#include <set>
#include <tuple>

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
    std::vector<std::vector<int>> verticalTraversal(TreeNode* root) {
        std::vector<std::vector<int>> result;
        if (!root) {
            return result;
        }

        std::map<int, std::map<int, std::multiset<int>>> nodes;
        std::queue<std::tuple<TreeNode*, int, int>> q;
        q.push({root, 0, 0});

        while (!q.empty()) {
            auto [node, row, col] = q.front();
            q.pop();

            nodes[col][row].insert(node->val);

            if (node->left) {
                q.push({node->left, row + 1, col - 1});
            }
            if (node->right) {
                q.push({node->right, row + 1, col + 1});
            }
        }

        for (auto const& [col, row_map] : nodes) {
            std::vector<int> current_col_nodes;
            for (auto const& [row, val_set] : row_map) {
                for (int val : val_set) {
                    current_col_nodes.push_back(val);
                }
            }
            result.push_back(current_col_nodes);
        }

        return result;
    }
};
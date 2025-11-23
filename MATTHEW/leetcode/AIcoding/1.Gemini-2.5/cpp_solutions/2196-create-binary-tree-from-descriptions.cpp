#include <vector>
#include <map>
#include <set>

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
    TreeNode* createBinaryTree(std::vector<std::vector<int>>& descriptions) {
        std::map<int, TreeNode*> nodes;
        std::set<int> children;

        for (const auto& desc : descriptions) {
            int parent_val = desc[0];
            int child_val = desc[1];
            int is_left = desc[2];

            if (nodes.find(parent_val) == nodes.end()) {
                nodes[parent_val] = new TreeNode(parent_val);
            }
            if (nodes.find(child_val) == nodes.end()) {
                nodes[child_val] = new TreeNode(child_val);
            }

            if (is_left == 1) {
                nodes[parent_val]->left = nodes[child_val];
            } else {
                nodes[parent_val]->right = nodes[child_val];
            }

            children.insert(child_val);
        }

        TreeNode* root = nullptr;
        for (const auto& pair : nodes) {
            if (children.find(pair.first) == children.end()) {
                root = pair.second;
                break;
            }
        }

        return root;
    }
};
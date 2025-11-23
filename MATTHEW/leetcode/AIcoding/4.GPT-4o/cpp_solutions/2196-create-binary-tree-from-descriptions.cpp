#include <unordered_map>
#include <vector>

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    TreeNode* createBinaryTree(std::vector<std::vector<int>>& descriptions) {
        std::unordered_map<int, TreeNode*> nodes;
        std::unordered_map<int, bool> isChild;

        for (const auto& desc : descriptions) {
            int parentVal = desc[0], childVal = desc[1];
            bool isLeft = desc[2];

            if (nodes.find(parentVal) == nodes.end()) {
                nodes[parentVal] = new TreeNode(parentVal);
            }
            if (nodes.find(childVal) == nodes.end()) {
                nodes[childVal] = new TreeNode(childVal);
            }

            if (isLeft) {
                nodes[parentVal]->left = nodes[childVal];
            } else {
                nodes[parentVal]->right = nodes[childVal];
            }
            isChild[childVal] = true;
        }

        for (const auto& node : nodes) {
            if (isChild.find(node.first) == isChild.end()) {
                return node.second;
            }
        }
        return nullptr;
    }
};
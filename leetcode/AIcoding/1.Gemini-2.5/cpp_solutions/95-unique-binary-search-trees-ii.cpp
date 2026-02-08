#include <vector>

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
    std::vector<TreeNode*> generateTrees(int n) {
        if (n == 0) {
            return {};
        }
        return generateTreesRecursive(1, n);
    }

private:
    std::vector<TreeNode*> generateTreesRecursive(int start, int end) {
        std::vector<TreeNode*> result;

        if (start > end) {
            result.push_back(nullptr);
            return result;
        }

        for (int i = start; i <= end; ++i) {
            std::vector<TreeNode*> leftSubtrees = generateTreesRecursive(start, i - 1);
            std::vector<TreeNode*> rightSubtrees = generateTreesRecursive(i + 1, end);

            for (TreeNode* left : leftSubtrees) {
                for (TreeNode* right : rightSubtrees) {
                    TreeNode* root = new TreeNode(i);
                    root->left = left;
                    root->right = right;
                    result.push_back(root);
                }
            }
        }
        return result;
    }
};
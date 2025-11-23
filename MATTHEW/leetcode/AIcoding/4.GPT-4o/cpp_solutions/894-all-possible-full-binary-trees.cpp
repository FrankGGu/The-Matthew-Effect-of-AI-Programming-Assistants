#include <vector>

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    std::vector<TreeNode*> allPossibleFBT(int N) {
        if (N % 2 == 0) return {};
        if (N == 1) return {new TreeNode(0)};

        std::vector<TreeNode*> res;
        for (int left = 1; left < N; left += 2) {
            int right = N - 1 - left;
            for (auto l : allPossibleFBT(left)) {
                for (auto r : allPossibleFBT(right)) {
                    TreeNode* root = new TreeNode(0);
                    root->left = l;
                    root->right = r;
                    res.push_back(root);
                }
            }
        }
        return res;
    }
};
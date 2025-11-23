#include <vector>
#include <unordered_map>
#include <algorithm>

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
    TreeNode* buildTree(std::vector<int>& inorder, std::vector<int>& postorder) {
        if (inorder.empty() || postorder.empty()) {
            return nullptr;
        }

        std::unordered_map<int, int> inMap;
        for (int i = 0; i < inorder.size(); ++i) {
            inMap[inorder[i]] = i;
        }

        return build(inorder, 0, inorder.size() - 1, 
                     postorder, 0, postorder.size() - 1, 
                     inMap);
    }

private:
    TreeNode* build(const std::vector<int>& inorder, int inStart, int inEnd, 
                    const std::vector<int>& postorder, int postStart, int postEnd,
                    std::unordered_map<int, int>& inMap) {

        if (inStart > inEnd || postStart > postEnd) {
            return nullptr;
        }

        int rootVal = postorder[postEnd];
        TreeNode* root = new TreeNode(rootVal);

        int inRootIdx = inMap[rootVal];

        int numsLeft = inRootIdx - inStart;

        root->left = build(inorder, inStart, inRootIdx - 1, 
                           postorder, postStart, postStart + numsLeft - 1, 
                           inMap);

        root->right = build(inorder, inRootIdx + 1, inEnd, 
                            postorder, postStart + numsLeft, postEnd - 1, 
                            inMap);

        return root;
    }
};
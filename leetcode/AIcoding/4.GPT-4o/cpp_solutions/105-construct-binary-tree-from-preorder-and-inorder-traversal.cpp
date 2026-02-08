#include <vector>
using namespace std;

struct TreeNode {
    int val;
    TreeNode* left;
    TreeNode* right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    TreeNode* buildTree(vector<int>& preorder, vector<int>& inorder) {
        return build(preorder, 0, preorder.size() - 1, inorder, 0, inorder.size() - 1);
    }

private:
    TreeNode* build(vector<int>& preorder, int preStart, int preEnd, vector<int>& inorder, int inStart, int inEnd) {
        if (preStart > preEnd || inStart > inEnd) return nullptr;
        TreeNode* root = new TreeNode(preorder[preStart]);
        int inRootIndex = find(inorder.begin() + inStart, inorder.begin() + inEnd + 1, root->val) - inorder.begin();
        int leftSize = inRootIndex - inStart;

        root->left = build(preorder, preStart + 1, preStart + leftSize, inorder, inStart, inRootIndex - 1);
        root->right = build(preorder, preStart + leftSize + 1, preEnd, inorder, inRootIndex + 1, inEnd);

        return root;
    }
};
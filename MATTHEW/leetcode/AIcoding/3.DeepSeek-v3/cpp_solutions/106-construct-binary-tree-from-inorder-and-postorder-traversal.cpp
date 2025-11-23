using namespace std;

class Solution {
    unordered_map<int, int> inorderMap;

    TreeNode* buildTreeHelper(vector<int>& inorder, vector<int>& postorder, int inStart, int inEnd, int postStart, int postEnd) {
        if (inStart > inEnd || postStart > postEnd) {
            return nullptr;
        }

        int rootVal = postorder[postEnd];
        TreeNode* root = new TreeNode(rootVal);

        int rootIndex = inorderMap[rootVal];
        int leftSubtreeSize = rootIndex - inStart;

        root->left = buildTreeHelper(inorder, postorder, inStart, rootIndex - 1, postStart, postStart + leftSubtreeSize - 1);
        root->right = buildTreeHelper(inorder, postorder, rootIndex + 1, inEnd, postStart + leftSubtreeSize, postEnd - 1);

        return root;
    }

public:
    TreeNode* buildTree(vector<int>& inorder, vector<int>& postorder) {
        for (int i = 0; i < inorder.size(); i++) {
            inorderMap[inorder[i]] = i;
        }
        return buildTreeHelper(inorder, postorder, 0, inorder.size() - 1, 0, postorder.size() - 1);
    }
};
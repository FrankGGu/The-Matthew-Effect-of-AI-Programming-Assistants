#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    TreeNode* buildTree(vector<int>& preorder, vector<int>& inorder) {
        unordered_map<int, int> indexMap;
        for (int i = 0; i < inorder.size(); ++i) {
            indexMap[inorder[i]] = i;
        }
        return buildTree(preorder, 0, preorder.size() - 1, inorder, 0, inorder.size() - 1, indexMap);
    }

private:
    TreeNode* buildTree(vector<int>& preorder, int preStart, int preEnd, vector<int>& inorder, int inStart, int inEnd, unordered_map<int, int>& indexMap) {
        if (preStart > preEnd || inStart > inEnd) {
            return NULL;
        }
        int rootVal = preorder[preStart];
        TreeNode* root = new TreeNode(rootVal);
        int rootIndex = indexMap[rootVal];
        int leftSubtreeSize = rootIndex - inStart;
        root->left = buildTree(preorder, preStart + 1, preStart + leftSubtreeSize, inorder, inStart, rootIndex - 1, indexMap);
        root->right = buildTree(preorder, preStart + leftSubtreeSize + 1, preEnd, inorder, rootIndex + 1, inEnd, indexMap);
        return root;
    }
};
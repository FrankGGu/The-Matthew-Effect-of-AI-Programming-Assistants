#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    TreeNode* buildTree(vector<int>& inorder, vector<int>& postorder) {
        unordered_map<int, int> indexMap;
        for (int i = 0; i < inorder.size(); ++i) {
            indexMap[inorder[i]] = i;
        }
        return build(inorder, 0, inorder.size() - 1, postorder, 0, postorder.size() - 1, indexMap);
    }

private:
    TreeNode* build(vector<int>& inorder, int inStart, int inEnd, vector<int>& postorder, int postStart, int postEnd, unordered_map<int, int>& indexMap) {
        if (inStart > inEnd || postStart > postEnd) {
            return nullptr;
        }
        int rootVal = postorder[postEnd];
        TreeNode* root = new TreeNode(rootVal);
        int rootIndex = indexMap[rootVal];
        int leftSubtreeSize = rootIndex - inStart;
        root->left = build(inorder, inStart, rootIndex - 1, postorder, postStart, postStart + leftSubtreeSize - 1, indexMap);
        root->right = build(inorder, rootIndex + 1, inEnd, postorder, postStart + leftSubtreeSize, postEnd - 1, indexMap);
        return root;
    }
};
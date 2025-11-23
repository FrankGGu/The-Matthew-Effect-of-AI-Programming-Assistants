#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

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
    TreeNode* buildTree(vector<int>& preorder, vector<int>& postorder) {
        unordered_map<int, int> indexMap;
        for (int i = 0; i < postorder.size(); ++i) {
            indexMap[postorder[i]] = i;
        }
        return helper(preorder, 0, preorder.size() - 1, postorder, 0, postorder.size() - 1, indexMap);
    }

private:
    TreeNode* helper(vector<int>& preorder, int preStart, int preEnd, vector<int>& postorder, int postStart, int postEnd, unordered_map<int, int>& indexMap) {
        if (preStart > preEnd) return nullptr;
        if (preStart == preEnd) return new TreeNode(preorder[preStart]);

        int rootVal = preorder[preStart];
        int leftRootVal = preorder[preStart + 1];
        int leftRootIndex = indexMap[leftRootVal];

        int leftSize = leftRootIndex - postStart + 1;

        TreeNode* root = new TreeNode(rootVal);
        root->left = helper(preorder, preStart + 1, preStart + leftSize, postorder, postStart, leftRootIndex, indexMap);
        root->right = helper(preorder, preStart + leftSize + 1, preEnd, postorder, leftRootIndex + 1, postEnd, indexMap);

        return root;
    }
};
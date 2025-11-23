using namespace std;

class Solution {
public:
    TreeNode* buildTree(vector<int>& preorder, vector<int>& inorder) {
        unordered_map<int, int> inMap;
        for (int i = 0; i < inorder.size(); ++i) {
            inMap[inorder[i]] = i;
        }
        return build(preorder, 0, preorder.size()-1, inorder, 0, inorder.size()-1, inMap);
    }

    TreeNode* build(vector<int>& preorder, int preStart, int preEnd, 
                    vector<int>& inorder, int inStart, int inEnd, 
                    unordered_map<int, int>& inMap) {
        if (preStart > preEnd || inStart > inEnd) return nullptr;

        TreeNode* root = new TreeNode(preorder[preStart]);
        int inRoot = inMap[root->val];
        int leftSize = inRoot - inStart;

        root->left = build(preorder, preStart+1, preStart+leftSize, 
                          inorder, inStart, inRoot-1, inMap);
        root->right = build(preorder, preStart+leftSize+1, preEnd, 
                          inorder, inRoot+1, inEnd, inMap);

        return root;
    }
};
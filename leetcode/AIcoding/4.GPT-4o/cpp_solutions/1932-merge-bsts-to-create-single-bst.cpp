class Solution {
public:
    TreeNode* mergeTrees(TreeNode* root1, TreeNode* root2) {
        if (!root1) return root2;
        if (!root2) return root1;
        root1->val += root2->val;
        root1->left = mergeTrees(root1->left, root2->left);
        root1->right = mergeTrees(root1->right, root2->right);
        return root1;
    }

    void inorder(TreeNode* root, vector<int>& vals) {
        if (!root) return;
        inorder(root->left, vals);
        vals.push_back(root->val);
        inorder(root->right, vals);
    }

    TreeNode* sortedArrayToBST(vector<int>& vals, int left, int right) {
        if (left > right) return nullptr;
        int mid = left + (right - left) / 2;
        TreeNode* node = new TreeNode(vals[mid]);
        node->left = sortedArrayToBST(vals, left, mid - 1);
        node->right = sortedArrayToBST(vals, mid + 1, right);
        return node;
    }

    TreeNode* canMerge(vector<TreeNode*>& trees) {
        vector<int> vals;
        for (auto tree : trees) {
            inorder(tree, vals);
        }
        sort(vals.begin(), vals.end());
        return sortedArrayToBST(vals, 0, vals.size() - 1);
    }
};
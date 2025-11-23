class FindElements {
private:
    unordered_set<int> values;

    void recover(TreeNode* root, int val) {
        if (!root) return;
        root->val = val;
        values.insert(val);
        recover(root->left, 2 * val + 1);
        recover(root->right, 2 * val + 2);
    }

public:
    FindElements(TreeNode* root) {
        recover(root, 0);
    }

    bool find(int target) {
        return values.find(target) != values.end();
    }
};
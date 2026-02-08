class FindElements {
public:
    unordered_set<int> values;

    void recover(TreeNode* root, int val) {
        if (!root) return;
        values.insert(val);
        recover(root->left, 2 * val + 1);
        recover(root->right, 2 * val + 2);
    }

    FindElements(TreeNode* root) {
        recover(root, 0);
    }

    bool find(int target) {
        return values.count(target) > 0;
    }
};
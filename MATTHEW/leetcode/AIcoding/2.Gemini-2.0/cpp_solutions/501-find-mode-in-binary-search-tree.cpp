class Solution {
public:
    vector<int> findMode(TreeNode* root) {
        vector<int> modes;
        int max_freq = 0;
        int curr_freq = 0;
        int curr_val = INT_MIN;

        function<void(TreeNode*)> inorder = [&](TreeNode* node) {
            if (!node) return;
            inorder(node->left);

            if (node->val == curr_val) {
                curr_freq++;
            } else {
                curr_freq = 1;
                curr_val = node->val;
            }

            if (curr_freq > max_freq) {
                max_freq = curr_freq;
                modes.clear();
                modes.push_back(curr_val);
            } else if (curr_freq == max_freq) {
                modes.push_back(curr_val);
            }

            inorder(node->right);
        };

        inorder(root);
        return modes;
    }
};
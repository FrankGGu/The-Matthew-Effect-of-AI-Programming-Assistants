class Solution {
public:
    int pseudoPalindromicPaths (TreeNode* root) {
        int count = 0;
        vector<int> path;
        function<void(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return;
            path.push_back(node->val);
            if (!node->left && !node->right) {
                vector<int> freq(10, 0);
                for (int val : path) {
                    freq[val]++;
                }
                int oddCount = 0;
                for (int i = 1; i < 10; i++) {
                    if (freq[i] % 2 != 0) {
                        oddCount++;
                    }
                }
                if (oddCount <= 1) {
                    count++;
                }
            } else {
                dfs(node->left);
                dfs(node->right);
            }
            path.pop_back();
        };
        dfs(root);
        return count;
    }
};
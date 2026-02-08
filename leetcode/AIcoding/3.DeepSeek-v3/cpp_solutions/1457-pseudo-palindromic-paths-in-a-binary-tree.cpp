class Solution {
public:
    int pseudoPalindromicPaths (TreeNode* root) {
        int count = 0;
        vector<int> freq(10, 0);
        dfs(root, freq, count);
        return count;
    }

private:
    void dfs(TreeNode* node, vector<int>& freq, int& count) {
        if (!node) return;

        freq[node->val]++;

        if (!node->left && !node->right) {
            int odd = 0;
            for (int num : freq) {
                if (num % 2 != 0) {
                    odd++;
                }
            }
            if (odd <= 1) {
                count++;
            }
        }

        dfs(node->left, freq, count);
        dfs(node->right, freq, count);

        freq[node->val]--;
    }
};
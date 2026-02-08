class Solution {
public:
    int componentValue(TreeNode* root, vector<int>& nums) {
        int total = accumulate(nums.begin(), nums.end(), 0);
        unordered_map<int, int> count;
        for (int num : nums) count[num]++;

        function<int(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return 0;
            int left = dfs(node->left);
            int right = dfs(node->right);
            count[left]--;
            count[right]--;
            return left + right + node->val;
        };

        dfs(root);

        int result = 0;
        for (int i = 1; i <= total; i++) {
            if (total % i == 0 && count[i] >= 0) {
                result = max(result, count[i]);
            }
        }

        return result;
    }
};
class Solution {
public:
    vector<int> findFrequentTreeSum(TreeNode* root) {
        unordered_map<int, int> sumCount;
        int maxCount = 0;
        vector<int> result;

        function<int(TreeNode*)> subtreeSum = [&](TreeNode* node) {
            if (!node) return 0;
            int leftSum = subtreeSum(node->left);
            int rightSum = subtreeSum(node->right);
            int sum = node->val + leftSum + rightSum;
            sumCount[sum]++;
            if (sumCount[sum] > maxCount) {
                maxCount = sumCount[sum];
                result.clear();
                result.push_back(sum);
            } else if (sumCount[sum] == maxCount) {
                result.push_back(sum);
            }
            return sum;
        };

        subtreeSum(root);
        return result;
    }
};
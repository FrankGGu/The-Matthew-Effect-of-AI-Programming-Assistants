class Solution {
public:
    vector<int> findFrequentTreeSum(TreeNode* root) {
        unordered_map<int, int> freq;
        int maxFreq = 0;
        postOrder(root, freq, maxFreq);
        vector<int> result;
        for (auto& [sum, cnt] : freq) {
            if (cnt == maxFreq) {
                result.push_back(sum);
            }
        }
        return result;
    }

private:
    int postOrder(TreeNode* node, unordered_map<int, int>& freq, int& maxFreq) {
        if (!node) return 0;
        int leftSum = postOrder(node->left, freq, maxFreq);
        int rightSum = postOrder(node->right, freq, maxFreq);
        int sum = node->val + leftSum + rightSum;
        freq[sum]++;
        maxFreq = max(maxFreq, freq[sum]);
        return sum;
    }
};
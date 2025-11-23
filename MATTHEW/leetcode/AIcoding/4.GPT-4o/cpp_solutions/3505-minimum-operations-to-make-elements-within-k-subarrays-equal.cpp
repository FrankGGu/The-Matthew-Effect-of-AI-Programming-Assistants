class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        int n = nums.size();
        unordered_map<int, int> freq;
        int left = 0, result = INT_MAX, current_ops = 0;

        for (int right = 0; right < n; ++right) {
            if (++freq[nums[right]] == 1) current_ops++;
            while (current_ops > k) {
                if (--freq[nums[left]] == 0) current_ops--;
                left++;
            }
            result = min(result, right - left + 1 - current_ops);
        }
        return result == INT_MAX ? 0 : result;
    }
};
class Solution {
public:
    int minSubarray(vector<int>& nums, int p) {
        int n = nums.size();
        int total = 0;
        for (int num : nums) {
            total = (total + num) % p;
        }
        if (total == 0) return 0;

        unordered_map<int, int> prefix;
        prefix[0] = -1;
        int res = n;
        int sum = 0;
        for (int i = 0; i < n; ++i) {
            sum = (sum + nums[i]) % p;
            int target = (sum - total + p) % p;
            if (prefix.count(target)) {
                res = min(res, i - prefix[target]);
            }
            prefix[sum] = i;
        }
        return res < n ? res : -1;
    }
};
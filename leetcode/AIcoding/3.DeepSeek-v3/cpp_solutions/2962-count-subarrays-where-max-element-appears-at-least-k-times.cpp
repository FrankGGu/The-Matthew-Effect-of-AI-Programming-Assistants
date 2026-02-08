class Solution {
public:
    long long countSubarrays(vector<int>& nums, int k) {
        int max_num = *max_element(nums.begin(), nums.end());
        int n = nums.size();
        long long res = 0;
        int cnt = 0;
        int left = 0;

        for (int right = 0; right < n; ++right) {
            if (nums[right] == max_num) {
                cnt++;
            }
            while (cnt >= k) {
                res += n - right;
                if (nums[left] == max_num) {
                    cnt--;
                }
                left++;
            }
        }

        return res;
    }
};
class Solution {
public:
    int countAlternatingSubarrays(vector<int>& nums) {
        int count = 0, n = nums.size();
        for (int i = 0; i < n; i++) {
            if (nums[i] % 2 == 0) {
                int len = 1;
                while (i + 1 < n && nums[i] + 1 == nums[i + 1]) {
                    len++;
                    i++;
                }
                count += len;
            }
        }
        return count;
    }
};
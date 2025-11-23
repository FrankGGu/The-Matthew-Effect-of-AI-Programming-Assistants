class Solution {
public:
    int partitionArray(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        int count = 1;
        int start = nums[0];

        for (int num : nums) {
            if (num - start > k) {
                count++;
                start = num;
            }
        }

        return count;
    }
};
class Solution {
public:
    int numSubarrayBoundedMax(vector<int>& nums, int left, int right) {
        return atMost(nums, right) - atMost(nums, left - 1);
    }

private:
    int atMost(vector<int>& nums, int bound) {
        int count = 0, start = 0;
        for (int end = 0; end < nums.size(); end++) {
            if (nums[end] > bound) {
                start = end + 1;
            }
            count += end - start + 1;
        }
        return count;
    }
};
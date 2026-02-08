class Solution {
public:
    int findUnsortedSubarray(vector<int>& nums) {
        vector<int> sorted_nums = nums;
        sort(sorted_nums.begin(), sorted_nums.end());
        int left = 0, right = nums.size() - 1;

        while (left < nums.size() && nums[left] == sorted_nums[left]) {
            left++;
        }
        while (right > left && nums[right] == sorted_nums[right]) {
            right--;
        }

        return right - left + 1;
    }
};
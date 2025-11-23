class Solution {
public:
    int countGood(int* nums, int numsSize) {
        int count = 0;
        for (int i = 0; i <= numsSize - 3; i++) {
            if (nums[i] < nums[i + 1] && nums[i + 1] < nums[i + 2]) {
                count++;
            }
        }
        return count;
    }
};
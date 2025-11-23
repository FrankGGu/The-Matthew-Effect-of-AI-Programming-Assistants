class Solution {
public:
    int countGood(int* nums, int numsSize) {
        unordered_map<int, int> count;
        long long total = 0;
        int left = 0;

        for (int right = 0; right < numsSize; right++) {
            count[nums[right]]++;
            while (count.size() > 2) {
                count[nums[left]]--;
                if (count[nums[left]] == 0) {
                    count.erase(nums[left]);
                }
                left++;
            }
            total += right - left + 1;
        }

        return total;
    }
};
class Solution {
public:
    int differenceSum(vector<int>& nums) {
        int total = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                total += abs(sumDigits(nums[i]) - sumDigits(nums[j]));
            }
        }
        return total;
    }

    int sumDigits(int num) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }
};
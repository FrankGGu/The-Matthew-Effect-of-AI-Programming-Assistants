class Solution {
public:
    int sumDigits(int n) {
        int sum = 0;
        if (n == 0) {
            return 0;
        }
        while (n > 0) {
            sum += n % 10;
            n /= 10;
        }
        return sum;
    }

    int smallestEqual(std::vector<int>& nums) {
        for (int i = 0; i < nums.size(); ++i) {
            if (sumDigits(i) % 10 == nums[i]) {
                return i;
            }
        }
        return -1;
    }
};
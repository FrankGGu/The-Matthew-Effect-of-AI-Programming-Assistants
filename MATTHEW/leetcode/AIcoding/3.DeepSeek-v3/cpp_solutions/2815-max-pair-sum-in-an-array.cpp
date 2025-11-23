class Solution {
public:
    int maxSum(vector<int>& nums) {
        unordered_map<int, int> maxDigits;
        int maxSum = -1;

        for (int num : nums) {
            int maxDigit = 0;
            int temp = num;
            while (temp > 0) {
                int digit = temp % 10;
                if (digit > maxDigit) {
                    maxDigit = digit;
                }
                temp /= 10;
            }

            if (maxDigits.find(maxDigit) != maxDigits.end()) {
                int sum = maxDigits[maxDigit] + num;
                if (sum > maxSum) {
                    maxSum = sum;
                }
                if (num > maxDigits[maxDigit]) {
                    maxDigits[maxDigit] = num;
                }
            } else {
                maxDigits[maxDigit] = num;
            }
        }

        return maxSum;
    }
};
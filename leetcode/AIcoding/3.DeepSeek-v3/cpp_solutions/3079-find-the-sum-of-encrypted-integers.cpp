class Solution {
public:
    int sumOfEncryptedNumbers(vector<int>& nums) {
        int sum = 0;
        for (int num : nums) {
            int maxDigit = 0;
            int temp = num;
            int count = 0;
            while (temp > 0) {
                int digit = temp % 10;
                if (digit > maxDigit) {
                    maxDigit = digit;
                }
                temp /= 10;
                count++;
            }
            int encrypted = 0;
            for (int i = 0; i < count; i++) {
                encrypted = encrypted * 10 + maxDigit;
            }
            sum += encrypted;
        }
        return sum;
    }
};
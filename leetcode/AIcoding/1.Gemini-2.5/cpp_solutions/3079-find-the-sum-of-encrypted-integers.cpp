#include <vector>
#include <string>
#include <algorithm>
#include <cmath>

class Solution {
public:
    long long sumOfEncryptedInt(std::vector<int>& nums) {
        long long totalSum = 0;
        for (int num : nums) {
            if (num == 0) {
                totalSum += 0;
                continue;
            }

            int maxDigit = 0;
            int tempNum = num;
            int digitCount = 0;

            while (tempNum > 0) {
                int digit = tempNum % 10;
                if (digit > maxDigit) {
                    maxDigit = digit;
                }
                digitCount++;
                tempNum /= 10;
            }

            long long encryptedNum = 0;
            for (int i = 0; i < digitCount; ++i) {
                encryptedNum = encryptedNum * 10 + maxDigit;
            }
            totalSum += encryptedNum;
        }
        return totalSum;
    }
};
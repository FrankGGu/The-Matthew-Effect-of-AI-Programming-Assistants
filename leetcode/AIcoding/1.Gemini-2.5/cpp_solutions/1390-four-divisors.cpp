#include <vector>
#include <cmath>

class Solution {
public:
    int sumFourDivisors(std::vector<int>& nums) {
        int totalSum = 0;
        for (int num : nums) {
            int count = 0;
            int divisorSum = 0;

            for (int i = 1; i * i <= num; ++i) {
                if (num % i == 0) {
                    if (i * i == num) {
                        count++;
                        divisorSum += i;
                    } else {
                        count += 2;
                        divisorSum += i + num / i;
                    }
                }
            }

            if (count == 4) {
                totalSum += divisorSum;
            }
        }
        return totalSum;
    }
};
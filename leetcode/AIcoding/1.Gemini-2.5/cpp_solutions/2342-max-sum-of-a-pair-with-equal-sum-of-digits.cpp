#include <vector>
#include <string>
#include <numeric>
#include <algorithm>
#include <map>

class Solution {
public:
    int getSumOfDigits(int n) {
        int sum = 0;
        while (n > 0) {
            sum += n % 10;
            n /= 10;
        }
        return sum;
    }

    int maximumSum(std::vector<int>& nums) {
        std::map<int, std::vector<int>> groups;

        for (int num : nums) {
            groups[getSumOfDigits(num)].push_back(num);
        }

        int maxSum = -1;

        for (auto const& [sumOfDigits, numbersList] : groups) {
            if (numbersList.size() >= 2) {
                int largest1 = 0;
                int largest2 = 0;

                for (int num : numbersList) {
                    if (num > largest1) {
                        largest2 = largest1;
                        largest1 = num;
                    } else if (num > largest2) {
                        largest2 = num;
                    }
                }
                maxSum = std::max(maxSum, largest1 + largest2);
            }
        }

        return maxSum;
    }
};
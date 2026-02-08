#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int maximumSum(std::vector<int>& nums) {
        std::unordered_map<int, int> sumMap;
        int maxSum = -1;

        for (int num : nums) {
            int digitSum = getDigitSum(num);
            if (sumMap.find(digitSum) != sumMap.end()) {
                maxSum = std::max(maxSum, sumMap[digitSum] + num);
            }
            sumMap[digitSum] = std::max(sumMap[digitSum], num);
        }

        return maxSum;
    }

private:
    int getDigitSum(int num) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }
};
#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumSum(int n, vector<int>& nums) {
        unordered_map<int, int> sumMap;
        int maxSum = -1;

        for (int num : nums) {
            int digitSum = 0;
            int temp = num;
            while (temp > 0) {
                digitSum += temp % 10;
                temp /= 10;
            }

            if (sumMap.find(digitSum) != sumMap.end()) {
                maxSum = max(maxSum, sumMap[digitSum] + num);
            }
            sumMap[digitSum] = max(sumMap[digitSum], num);
        }

        return maxSum;
    }
};
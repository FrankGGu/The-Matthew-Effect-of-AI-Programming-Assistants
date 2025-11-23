#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minOperationsToExceedThreshold(vector<int>& nums, int threshold) {
        int operations = 0;
        int currentSum = 0;
        for (int num : nums) {
            currentSum += num;
            if (currentSum > threshold) {
                return operations + 1;
            }
            operations++;
        }
        return -1;
    }
};
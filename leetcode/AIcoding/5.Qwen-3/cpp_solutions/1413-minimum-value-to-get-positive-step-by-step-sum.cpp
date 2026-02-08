#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minStartValue(vector<int>& nums) {
        int sum = 0;
        int minSum = 0;
        for (int num : nums) {
            sum += num;
            minSum = min(minSum, sum);
        }
        return abs(minSum) + 1;
    }
};
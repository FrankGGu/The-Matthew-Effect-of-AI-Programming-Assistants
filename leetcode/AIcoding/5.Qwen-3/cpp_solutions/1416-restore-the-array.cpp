#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numberOfWeeks(vector<int>& nums) {
        long long total = 0;
        for (int num : nums) {
            total += num;
        }
        long long maxVal = *max_element(nums.begin(), nums.end());
        if (maxVal > total - maxVal) {
            return 2 * (total - maxVal) + 1;
        } else {
            return total;
        }
    }
};
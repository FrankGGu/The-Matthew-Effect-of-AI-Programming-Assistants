#include <iostream>
#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int minMoves(vector<int>& nums) {
        int minVal = *min_element(nums.begin(), nums.end());
        int sum = accumulate(nums.begin(), nums.end(), 0);
        return sum - minVal * nums.size();
    }
};
#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximizeTheMinimum(vector<int>& nums, int k) {
        long long sum = accumulate(nums.begin(), nums.end(), 0LL);
        return sum / k;
    }
};
#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maximizeSum(vector<int>& nums, int k) {
        int max_val = *max_element(nums.begin(), nums.end());
        return k * max_val + k * (k - 1) / 2;
    }
};
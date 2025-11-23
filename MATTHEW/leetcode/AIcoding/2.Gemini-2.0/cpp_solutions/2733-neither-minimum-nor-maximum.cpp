#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findNonMinOrMax(vector<int>& nums) {
        if (nums.size() <= 2) {
            return -1;
        }

        int a = nums[0];
        int b = nums[1];
        int c = nums[2];

        if ((a > min({a, b, c}) && a < max({a, b, c}))) return a;
        if ((b > min({a, b, c}) && b < max({a, b, c}))) return b;
        if ((c > min({a, b, c}) && c < max({a, b, c}))) return c;

        return -1;
    }
};
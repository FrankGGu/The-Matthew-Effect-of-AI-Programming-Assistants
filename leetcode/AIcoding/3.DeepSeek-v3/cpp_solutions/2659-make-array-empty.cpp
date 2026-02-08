#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    long long countOperationsToEmptyArray(vector<int>& nums) {
        int n = nums.size();
        map<int, int> pos;
        for (int i = 0; i < n; ++i) {
            pos[nums[i]] = i;
        }
        sort(nums.begin(), nums.end());
        long long res = n;
        for (int i = 1; i < n; ++i) {
            if (pos[nums[i]] < pos[nums[i-1]]) {
                res += n - i;
            }
        }
        return res;
    }
};
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int sumCounts(vector<int>& nums) {
        int n = nums.size();
        int ans = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                unordered_set<int> distinct;
                for (int k = i; k <= j; ++k) {
                    distinct.insert(nums[k]);
                }
                int count = distinct.size();
                ans += count * count;
            }
        }
        return ans;
    }
};
#include <vector>
#include <set>

using namespace std;

class Solution {
public:
    int sumCounts(vector<int>& nums) {
        int n = nums.size();
        long long ans = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                set<int> distinctElements;
                for (int k = i; k <= j; ++k) {
                    distinctElements.insert(nums[k]);
                }
                ans += (long long)distinctElements.size() * distinctElements.size();
            }
        }

        return ans % 1000000007;
    }
};
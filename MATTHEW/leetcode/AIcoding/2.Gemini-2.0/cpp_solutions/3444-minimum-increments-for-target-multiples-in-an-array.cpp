#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int minIncrementForTargetMultiples(vector<int>& nums, int target) {
        long long sum = 0;
        for (int num : nums) {
            sum += num;
        }

        long long l = 0, r = sum;
        long long ans = sum;

        while (l <= r) {
            long long mid = l + (r - l) / 2;
            long long totalMultiples = 0;
            for (int num : nums) {
                totalMultiples += (num + mid) / target;
            }

            if (totalMultiples == nums.size()) {
                ans = mid;
                r = mid - 1;
            } else {
                l = mid + 1;
            }
        }

        return ans;
    }
};
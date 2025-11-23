#include <vector>

using namespace std;

class Solution {
public:
    long long countPairs(vector<int>& nums) {
        int n = nums.size();
        long long ans = 0;
        vector<int> sorted;
        for (int i = 0; i < n; ++i) {
            int left = 0, right = sorted.size();
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (sorted[mid] <= nums[i]) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            ans += sorted.size() - left;

            left = 0, right = sorted.size();
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (sorted[mid] < nums[i]) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }

            sorted.insert(sorted.begin() + left, nums[i]);
        }
        return ans;
    }
};
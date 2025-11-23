#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minAbsoluteSumDifference(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        vector<int> sortedNums1 = nums1;
        sort(sortedNums1.begin(), sortedNums1.end());
        long long sum = 0;
        long long maxDiff = 0;
        for (int i = 0; i < n; ++i) {
            long long diff = abs(nums1[i] - nums2[i]);
            sum = (sum + diff) % 1000000007;
            int left = 0, right = n - 1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                long long currentDiff = abs(sortedNums1[mid] - nums2[i]);
                if (currentDiff < diff) {
                    maxDiff = max(maxDiff, diff - currentDiff);
                }
                if (sortedNums1[mid] < nums2[i]) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
        }
        return (sum - maxDiff + 1000000007) % 1000000007;
    }
};
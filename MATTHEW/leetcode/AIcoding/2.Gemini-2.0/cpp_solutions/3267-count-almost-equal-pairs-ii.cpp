#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long countAlmostEqualPairs(vector<int>& nums1, vector<int>& nums2, int diff) {
        int n = nums1.size();
        long long count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (abs(nums1[i] - nums1[j]) <= diff && abs(nums2[i] - nums2[j]) <= diff) {
                    count++;
                }
            }
        }
        return count;
    }
};
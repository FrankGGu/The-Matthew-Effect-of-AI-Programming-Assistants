#include <unordered_set>

class Solution {
public:
    int maximumSetSize(vector<int>& nums1, vector<int>& nums2) {
        unordered_set<int> s1(nums1.begin(), nums1.end());
        unordered_set<int> s2(nums2.begin(), nums2.end());
        int n = nums1.size();
        int common = 0;
        for (int num : s1) {
            if (s2.count(num)) {
                common++;
            }
        }
        int unique1 = s1.size() - common;
        int unique2 = s2.size() - common;

        int res = 0;
        int temp1 = min(unique1, n / 2);
        res += temp1;
        unique1 -= temp1;

        int temp2 = min(unique2, n / 2);
        res += temp2;
        unique2 -= temp2;

        int remaining = n - res;
        res += min(common, remaining);

        return res;
    }
};
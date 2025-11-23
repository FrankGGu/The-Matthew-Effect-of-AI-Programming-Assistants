#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int xorSum(vector<int>& nums1, vector<int>& nums2) {
        int result = 0;
        for (int i = 0; i < 32; ++i) {
            int cnt1 = 0, cnt2 = 0;
            for (int num : nums1) {
                if (num & (1 << i)) cnt1++;
            }
            for (int num : nums2) {
                if (num & (1 << i)) cnt2++;
            }
            if (cnt1 > 0 && cnt2 > 0) {
                result |= ((long long)cnt1 * cnt2) % 2 * (1 << i);
            }
        }
        return result;
    }
};
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        int m = nums2.size();
        int res = 0;
        for (int i = 0; i < n; ++i) {
            if (nums1[i] > nums2[i]) {
                swap(nums1[i], nums2[i]);
                ++res;
            }
        }
        return res;
    }
};
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getXValue(vector<int>& nums1, vector<int>& nums2) {
        sort(nums1.begin(), nums1.end());
        sort(nums2.begin(), nums2.end());

        int n = nums1.size();
        int m = nums2.size();

        int i = 0, j = 0;
        int count = 0;

        while (i < n && j < m) {
            if (nums1[i] < nums2[j]) {
                i++;
            } else if (nums1[i] > nums2[j]) {
                j++;
            } else {
                count++;
                i++;
                j++;
            }
        }

        return count;
    }
};
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxDistance(vector<int>& nums1, vector<int>& nums2) {
        int maxDist = 0;
        int i = 0, j = 0;
        while (i < nums1.size() && j < nums2.size()) {
            if (nums1[i] > nums2[j]) {
                i++;
            } else if (nums1[i] <= nums2[j]) {
                if (i < j) {
                    maxDist = max(maxDist, j - i);
                }
                j++;
            }
        }
        return maxDist;
    }
};
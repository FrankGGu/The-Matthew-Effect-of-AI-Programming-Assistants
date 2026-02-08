#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int countAlmostEqualPairs(vector<int>& nums1, vector<int>& nums2, int diff) {
        int count = 0;
        for (int i = 0; i < nums1.size(); ++i) {
            for (int j = 0; j < nums2.size(); ++j) {
                if (abs(nums1[i] - nums2[j]) <= diff) {
                    count++;
                }
            }
        }
        return count;
    }
};
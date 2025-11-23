#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minNumber(vector<int>& nums1, vector<int>& nums2) {
        sort(nums1.begin(), nums1.end());
        sort(nums2.begin(), nums2.end());

        for (int num1 : nums1) {
            for (int num2 : nums2) {
                if (num1 == num2) {
                    return num1;
                }
            }
        }

        int min1 = nums1[0];
        int min2 = nums2[0];

        if (min1 < min2) {
            return min1 * 10 + min2;
        } else {
            return min2 * 10 + min1;
        }
    }
};
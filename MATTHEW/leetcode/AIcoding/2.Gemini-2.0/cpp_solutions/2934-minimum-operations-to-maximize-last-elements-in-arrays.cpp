#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        int last1 = nums1[n - 1];
        int last2 = nums2[n - 1];

        int op1 = 0;
        for (int i = 0; i < n - 1; ++i) {
            if (nums1[i] > last1 || nums2[i] > last2) {
                if (nums1[i] > last2 || nums2[i] > last1) {
                    return -1;
                }
                op1++;
            }
        }

        int op2 = 1;
        for (int i = 0; i < n - 1; ++i) {
            if (nums1[i] > last2 || nums2[i] > last1) {
                if (nums1[i] > last1 || nums2[i] > last2) {
                    return min(op1, op2);
                }
                op2++;
            }
        }

        return min(op1, op2);
    }
};
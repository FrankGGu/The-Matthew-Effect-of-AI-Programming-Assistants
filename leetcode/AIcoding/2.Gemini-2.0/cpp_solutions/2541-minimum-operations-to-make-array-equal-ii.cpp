#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    long long minOperations(vector<int>& nums1, vector<int>& nums2, int k) {
        if (k == 0) {
            return nums1 == nums2 ? 0 : -1;
        }

        long long increase = 0;
        long long decrease = 0;

        for (int i = 0; i < nums1.size(); ++i) {
            int diff = nums1[i] - nums2[i];

            if (diff % k != 0) {
                return -1;
            }

            if (diff > 0) {
                increase += diff / k;
            } else if (diff < 0) {
                decrease -= diff / k;
            }
        }

        if (increase != decrease) {
            return -1;
        }

        return increase;
    }
};
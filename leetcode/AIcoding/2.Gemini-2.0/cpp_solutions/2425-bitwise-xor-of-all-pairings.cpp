#include <vector>

using namespace std;

class Solution {
public:
    int xorAllNums(vector<int>& nums1, vector<int>& nums2) {
        int n1 = nums1.size();
        int n2 = nums2.size();
        int result = 0;

        if (n2 % 2 != 0) {
            for (int num : nums1) {
                result ^= num;
            }
        }

        if (n1 % 2 != 0) {
            for (int num : nums2) {
                result ^= num;
            }
        }

        return result;
    }
};
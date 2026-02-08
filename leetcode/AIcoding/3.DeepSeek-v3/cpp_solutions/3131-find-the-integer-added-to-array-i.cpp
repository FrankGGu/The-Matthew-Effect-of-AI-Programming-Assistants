#include <vector>
using namespace std;

class Solution {
public:
    int addedInteger(vector<int>& nums1, vector<int>& nums2) {
        int sum1 = 0, sum2 = 0;
        for (int num : nums1) {
            sum1 += num;
        }
        for (int num : nums2) {
            sum2 += num;
        }
        return (sum2 - sum1);
    }
};
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSum(vector<int>& nums1, vector<int>& nums2) {
        int n1 = nums1.size();
        int n2 = nums2.size();
        int i = 0, j = 0;
        long long sum1 = 0, sum2 = 0;
        long long res = 0;
        int mod = 1e9 + 7;

        while (i < n1 || j < n2) {
            if (i < n1 && (j == n2 || nums1[i] < nums2[j])) {
                sum1 += nums1[i];
                i++;
            } else if (j < n2 && (i == n1 || nums2[j] < nums1[i])) {
                sum2 += nums2[j];
                j++;
            } else {
                res += max(sum1, sum2);
                res %= mod;
                sum1 = 0;
                sum2 = 0;
                sum1 += nums1[i];
                sum2 += nums2[j];
                i++;
                j++;
            }
        }

        res += max(sum1, sum2);
        res %= mod;
        return res;
    }
};
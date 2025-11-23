class Solution {
public:
    int maxSum(vector<int>& nums1, vector<int>& nums2) {
        const int MOD = 1e9 + 7;
        int m = nums1.size(), n = nums2.size();
        long long sum1 = 0, sum2 = 0;
        int i = 0, j = 0;
        long long res = 0;

        while (i < m && j < n) {
            if (nums1[i] < nums2[j]) {
                sum1 += nums1[i];
                i++;
            } else if (nums1[i] > nums2[j]) {
                sum2 += nums2[j];
                j++;
            } else {
                res += max(sum1, sum2) + nums1[i];
                sum1 = 0;
                sum2 = 0;
                i++;
                j++;
            }
        }

        while (i < m) {
            sum1 += nums1[i];
            i++;
        }

        while (j < n) {
            sum2 += nums2[j];
            j++;
        }

        res += max(sum1, sum2);
        return res % MOD;
    }
};
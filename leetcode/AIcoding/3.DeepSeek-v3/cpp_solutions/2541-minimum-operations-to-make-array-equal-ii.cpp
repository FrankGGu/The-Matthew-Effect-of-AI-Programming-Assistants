class Solution {
public:
    long long minOperations(vector<int>& nums1, vector<int>& nums2, int k) {
        long long pos = 0, neg = 0;
        for (int i = 0; i < nums1.size(); ++i) {
            long long diff = nums1[i] - nums2[i];
            if (k == 0) {
                if (diff != 0) return -1;
            } else {
                if (diff % k != 0) return -1;
                if (diff > 0) pos += diff / k;
                else neg += -diff / k;
            }
        }
        if (k == 0) return 0;
        return pos == neg ? pos : -1;
    }
};
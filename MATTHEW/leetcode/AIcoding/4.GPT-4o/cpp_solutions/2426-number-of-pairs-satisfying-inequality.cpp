class Solution {
public:
    int countPairs(vector<int>& nums1, vector<int>& nums2, int diff) {
        int n = nums1.size();
        vector<long long> prefix(n);
        for (int i = 0; i < n; ++i) {
            prefix[i] = (long long) nums1[i] - nums2[i];
        }
        sort(prefix.begin(), prefix.end());
        long long count = 0;
        for (int i = 0; i < n; ++i) {
            count += upper_bound(prefix.begin(), prefix.end(), prefix[i] + diff) - (prefix.begin() + i + 1);
        }
        return count;
    }
};
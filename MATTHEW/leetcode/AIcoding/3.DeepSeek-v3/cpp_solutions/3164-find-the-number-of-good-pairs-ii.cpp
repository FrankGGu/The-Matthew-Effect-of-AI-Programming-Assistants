class Solution {
public:
    long long numberOfPairs(vector<int>& nums1, vector<int>& nums2, int k) {
        unordered_map<long long, long long> freq;
        for (int num : nums2) {
            long long val = (long long)num * k;
            freq[val]++;
        }

        long long res = 0;
        for (int num : nums1) {
            for (long long d = 1; d * d <= num; ++d) {
                if (num % d == 0) {
                    if (freq.count(d)) {
                        res += freq[d];
                    }
                    long long other = num / d;
                    if (other != d && freq.count(other)) {
                        res += freq[other];
                    }
                }
            }
        }
        return res;
    }
};
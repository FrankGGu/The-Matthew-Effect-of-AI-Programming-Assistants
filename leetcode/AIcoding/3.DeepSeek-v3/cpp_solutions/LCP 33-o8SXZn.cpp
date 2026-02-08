class Solution {
public:
    int storeWater(vector<int>& bucket, vector<int>& vat) {
        int max_k = *max_element(vat.begin(), vat.end());
        if (max_k == 0) return 0;
        int res = INT_MAX;
        for (int k = 1; k <= max_k; ++k) {
            int t = 0;
            for (int i = 0; i < bucket.size(); ++i) {
                t += max(0, (vat[i] + k - 1) / k - bucket[i]);
            }
            res = min(res, t + k);
        }
        return res;
    }
};
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int storeWater(vector<int>& bucket, vector<int>& vat) {
        int n = bucket.size();
        int max_vat = 0;
        for (int v : vat) {
            max_vat = max(max_vat, v);
        }

        if (max_vat == 0) {
            return 0;
        }

        int ans = INT_MAX;
        for (int k = 1; k <= 10000; ++k) {
            int cur = k;
            for (int i = 0; i < n; ++i) {
                int times = (vat[i] + k - 1) / k;
                if (times > bucket[i]) {
                    cur += times - bucket[i];
                }
            }
            ans = min(ans, cur);
        }

        return ans;
    }
};
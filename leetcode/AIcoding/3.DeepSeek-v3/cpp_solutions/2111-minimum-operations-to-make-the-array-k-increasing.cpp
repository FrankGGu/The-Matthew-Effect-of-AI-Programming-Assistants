class Solution {
public:
    int kIncreasing(vector<int>& arr, int k) {
        int n = arr.size();
        int res = 0;
        for (int i = 0; i < k; ++i) {
            vector<int> subseq;
            for (int j = i; j < n; j += k) {
                auto it = upper_bound(subseq.begin(), subseq.end(), arr[j]);
                if (it == subseq.end()) {
                    subseq.push_back(arr[j]);
                } else {
                    *it = arr[j];
                }
            }
            res += subseq.size();
        }
        return n - res;
    }
};
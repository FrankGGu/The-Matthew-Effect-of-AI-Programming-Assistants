class Solution {
public:
    int countTriplets(vector<int>& arr) {
        int n = arr.size();
        int count = 0;
        vector<int> prefixXor(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            prefixXor[i + 1] = prefixXor[i] ^ arr[i];
        }

        for (int j = 0; j < n; ++j) {
            for (int k = j + 1; k <= n; ++k) {
                if (prefixXor[j] == prefixXor[k]) {
                    count += k - j - 1;
                }
            }
        }

        return count;
    }
};
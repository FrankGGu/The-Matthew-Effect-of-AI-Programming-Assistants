class Solution {
public:
    int maxChunksToSorted(vector<int>& arr) {
        int n = arr.size();
        vector<int> prefix(n), suffix(n);

        prefix[0] = arr[0];
        for (int i = 1; i < n; ++i) {
            prefix[i] = max(prefix[i - 1], arr[i]);
        }

        suffix[n - 1] = arr[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            suffix[i] = min(suffix[i + 1], arr[i]);
        }

        int chunks = 0;
        for (int i = 0; i < n - 1; ++i) {
            if (prefix[i] <= suffix[i + 1]) {
                chunks++;
            }
        }

        return chunks + 1;
    }
};
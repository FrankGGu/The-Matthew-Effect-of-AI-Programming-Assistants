class Solution {
public:
    int lenLongestFibSubseq(vector<int>& arr) {
        unordered_set<int> s(arr.begin(), arr.end());
        int n = arr.size();
        int max_len = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int a = arr[i], b = arr[j];
                int len = 2;
                while (s.count(a + b)) {
                    int c = a + b;
                    a = b;
                    b = c;
                    ++len;
                }
                if (len > 2) {
                    max_len = max(max_len, len);
                }
            }
        }

        return max_len;
    }
};
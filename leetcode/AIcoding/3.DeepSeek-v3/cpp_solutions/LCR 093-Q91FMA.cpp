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

                while (s.find(a + b) != s.end()) {
                    int c = a + b;
                    a = b;
                    b = c;
                    len++;
                }

                if (len > max_len && len >= 3) {
                    max_len = len;
                }
            }
        }

        return max_len;
    }
};
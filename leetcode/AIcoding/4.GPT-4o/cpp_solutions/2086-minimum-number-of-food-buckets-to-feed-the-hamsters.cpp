class Solution {
public:
    int minNumberOfBuckets(string s) {
        int n = s.size();
        vector<int> left(n, 0), right(n, 0);

        for (int i = 0; i < n; ++i) {
            if (s[i] == 'H') {
                if (i > 0 && s[i - 1] == 'B') left[i] = 1;
                if (i < n - 1 && s[i + 1] == 'B') right[i] = 1;
            }
        }

        int buckets = 0;
        for (int i = 0; i < n; ++i) {
            if (s[i] == 'H' && left[i] == 0 && right[i] == 0) {
                buckets++;
                if (i + 1 < n && s[i + 1] == '.') {
                    s[i + 1] = 'B';
                } else if (i - 1 >= 0 && s[i - 1] == '.') {
                    s[i - 1] = 'B';
                } else {
                    return -1;
                }
            }
        }

        return buckets;
    }
};
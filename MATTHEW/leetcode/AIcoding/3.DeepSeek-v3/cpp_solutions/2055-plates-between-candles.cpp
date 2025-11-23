class Solution {
public:
    vector<int> platesBetweenCandles(string s, vector<vector<int>>& queries) {
        int n = s.size();
        vector<int> prefix(n + 1, 0);
        vector<int> left(n, -1);
        vector<int> right(n, -1);

        int last = -1;
        for (int i = 0; i < n; ++i) {
            if (s[i] == '|') {
                last = i;
            }
            left[i] = last;
        }

        last = -1;
        for (int i = n - 1; i >= 0; --i) {
            if (s[i] == '|') {
                last = i;
            }
            right[i] = last;
        }

        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + (s[i] == '*' ? 1 : 0);
        }

        vector<int> res;
        for (auto& q : queries) {
            int l = q[0], r = q[1];
            int left_candle = right[l];
            int right_candle = left[r];
            if (left_candle == -1 || right_candle == -1 || left_candle >= right_candle) {
                res.push_back(0);
            } else {
                res.push_back(prefix[right_candle + 1] - prefix[left_candle]);
            }
        }
        return res;
    }
};
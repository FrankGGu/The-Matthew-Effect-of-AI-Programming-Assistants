class Solution {
public:
    vector<int> countOfPairs(int n, int x, int y) {
        vector<int> res(n, 0);
        for (int i = 1; i <= n; ++i) {
            for (int j = i + 1; j <= n; ++j) {
                int d = min(abs(i - j), abs(i - x) + 1 + abs(y - j));
                d = min(d, abs(i - y) + 1 + abs(x - j));
                res[d - 1] += 2;
            }
        }
        return res;
    }
};
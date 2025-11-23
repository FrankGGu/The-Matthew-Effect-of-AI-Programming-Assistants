class Solution {
public:
    vector<int> countOfPairs(int n, int x, int y) {
        vector<int> res(n, 0);
        if (x > y) swap(x, y);
        for (int i = 1; i <= n; ++i) {
            for (int j = i + 1; j <= n; ++j) {
                int d = min(j - i, abs(x - i) + 1 + abs(y - j));
                if (d - 1 < n) {
                    res[d - 1] += 2;
                }
            }
        }
        return res;
    }
};
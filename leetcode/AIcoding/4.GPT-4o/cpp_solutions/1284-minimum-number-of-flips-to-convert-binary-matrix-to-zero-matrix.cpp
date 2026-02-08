class Solution {
public:
    int minFlips(vector<vector<int>>& mat) {
        int m = mat.size(), n = mat[0].size();
        int target = 0;
        int start = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                target |= (mat[i][j] << (i * n + j));
            }
        }

        unordered_set<int> visited;
        queue<pair<int, int>> q;
        q.push({target, 0});
        visited.insert(target);

        while (!q.empty()) {
            auto [cur, steps] = q.front();
            q.pop();
            if (cur == 0) return steps;

            for (int i = 0; i < m; ++i) {
                for (int j = 0; j < n; ++j) {
                    int next = cur;
                    for (int x = -1; x <= 1; ++x) {
                        for (int y = -1; y <= 1; ++y) {
                            if (abs(x) == abs(y)) continue;
                            int ni = i + x, nj = j + y;
                            if (ni >= 0 && ni < m && nj >= 0 && nj < n) {
                                next ^= (1 << (ni * n + nj));
                            }
                        }
                    }
                    next ^= (1 << (i * n + j));
                    if (visited.count(next) == 0) {
                        visited.insert(next);
                        q.push({next, steps + 1});
                    }
                }
            }
        }

        return -1;
    }
};
class Solution {
public:
    bool canAssign(vector<int>& A, vector<int>& B, vector<vector<int>>& pairs) {
        int n = A.size(), m = B.size();
        vector<bool> visitedA(n, false), visitedB(m, false);
        vector<vector<int>> graph(n);

        for (auto& p : pairs) {
            graph[p[0]].push_back(p[1]);
        }

        function<bool(int)> dfs = [&](int a) {
            for (int b : graph[a]) {
                if (!visitedB[b]) {
                    visitedB[b] = true;
                    if (!visitedA[b] || dfs(visitedA[b] - 1)) {
                        visitedA[b] = a + 1;
                        return true;
                    }
                }
            }
            return false;
        };

        for (int i = 0; i < n; ++i) {
            fill(visitedB.begin(), visitedB.end(), false);
            if (!dfs(i)) return false;
        }
        return true;
    }
};
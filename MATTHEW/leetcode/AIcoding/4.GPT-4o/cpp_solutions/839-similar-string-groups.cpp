class Solution {
public:
    int numSimilarGroups(vector<string>& A) {
        int n = A.size();
        vector<bool> visited(n, false);
        int groups = 0;

        function<bool(const string&, const string&)> isSimilar = [](const string& a, const string& b) {
            int diff = 0;
            for (int i = 0; i < a.size(); ++i) {
                if (a[i] != b[i]) {
                    diff++;
                }
            }
            return diff == 2 || diff == 0;
        };

        function<void(int)> dfs = [&](int index) {
            visited[index] = true;
            for (int i = 0; i < n; ++i) {
                if (!visited[i] && isSimilar(A[index], A[i])) {
                    dfs(i);
                }
            }
        };

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                dfs(i);
                groups++;
            }
        }

        return groups;
    }
};
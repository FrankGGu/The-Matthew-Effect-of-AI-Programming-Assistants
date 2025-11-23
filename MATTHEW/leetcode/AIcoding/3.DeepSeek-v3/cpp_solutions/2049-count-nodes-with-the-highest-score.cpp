class Solution {
public:
    int countHighestScoreNodes(vector<int>& parents) {
        int n = parents.size();
        vector<vector<int>> children(n);
        for (int i = 1; i < n; ++i) {
            children[parents[i]].push_back(i);
        }

        vector<int> size(n, 0);
        long long maxScore = 0;
        int count = 0;

        function<void(int)> dfs = [&](int node) {
            long long score = 1;
            int total = 0;
            for (int child : children[node]) {
                dfs(child);
                score *= size[child];
                total += size[child];
            }
            if (n - total - 1 > 0) {
                score *= (n - total - 1);
            }
            if (score > maxScore) {
                maxScore = score;
                count = 1;
            } else if (score == maxScore) {
                ++count;
            }
            size[node] = total + 1;
        };

        dfs(0);
        return count;
    }
};
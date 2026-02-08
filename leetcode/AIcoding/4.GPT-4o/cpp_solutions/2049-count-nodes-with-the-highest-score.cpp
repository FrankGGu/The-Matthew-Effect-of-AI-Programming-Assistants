class Solution {
public:
    int countHighestScoreNodes(vector<int>& parents) {
        int n = parents.size();
        vector<vector<int>> tree(n);
        vector<long long> subtreeSize(n, 0);

        for (int i = 1; i < n; ++i) {
            tree[parents[i]].push_back(i);
        }

        function<long long(int)> dfs = [&](int node) {
            long long size = 1;
            for (int child : tree[node]) {
                size += dfs(child);
            }
            subtreeSize[node] = size;
            return size;
        };

        dfs(0);

        long long maxScore = 0;
        int count = 0;

        for (int i = 0; i < n; ++i) {
            long long score = 1;
            if (parents[i] != -1) {
                score *= (n - subtreeSize[i]);
            }
            for (int child : tree[i]) {
                score *= subtreeSize[child];
            }
            if (score > maxScore) {
                maxScore = score;
                count = 1;
            } else if (score == maxScore) {
                count++;
            }
        }

        return count;
    }
};
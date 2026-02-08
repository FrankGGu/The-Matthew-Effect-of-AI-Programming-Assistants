class Solution {
public:
    long long maximumImportance(int n, vector<vector<int>>& roads) {
        vector<int> degree(n, 0);
        for (auto& road : roads) {
            degree[road[0]]++;
            degree[road[1]]++;
        }
        sort(degree.begin(), degree.end());
        long long res = 0;
        for (int i = 0; i < n; ++i) {
            res += (long long)degree[i] * (i + 1);
        }
        return res;
    }
};
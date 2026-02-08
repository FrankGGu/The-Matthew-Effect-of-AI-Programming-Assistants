class Solution {
public:
    long long maximumImportance(int n, vector<vector<int>>& roads) {
        vector<int> degree(n, 0);
        for (const auto& road : roads) {
            degree[road[0]]++;
            degree[road[1]]++;
        }
        sort(degree.begin(), degree.end(), greater<int>());
        long long totalImportance = 0;
        for (int i = 0; i < n; ++i) {
            totalImportance += (i + 1) * degree[i];
        }
        return totalImportance;
    }
};
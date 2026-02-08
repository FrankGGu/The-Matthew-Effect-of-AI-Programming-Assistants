#include <vector>
#include <algorithm>

class Solution {
public:
    long long maximumImportance(int n, std::vector<std::vector<int>>& roads) {
        std::vector<long long> degree(n, 0);
        for (const auto& road : roads) {
            degree[road[0]]++;
            degree[road[1]]++;
        }

        std::sort(degree.begin(), degree.end());

        long long totalImportance = 0;
        for (long long i = 0; i < n; ++i) {
            totalImportance += degree[i] * (i + 1);
        }

        return totalImportance;
    }
};
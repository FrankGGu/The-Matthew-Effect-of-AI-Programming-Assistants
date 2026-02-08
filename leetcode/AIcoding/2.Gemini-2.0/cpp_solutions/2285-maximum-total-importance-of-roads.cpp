#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumImportance(int n, vector<vector<int>>& roads) {
        vector<int> degrees(n, 0);
        for (auto& road : roads) {
            degrees[road[0]]++;
            degrees[road[1]]++;
        }

        vector<pair<int, int>> nodeDegrees;
        for (int i = 0; i < n; ++i) {
            nodeDegrees.push_back({degrees[i], i});
        }

        sort(nodeDegrees.begin(), nodeDegrees.end());

        vector<long long> importance(n);
        long long currentImportance = 1;
        for (int i = 0; i < n; ++i) {
            importance[nodeDegrees[i].second] = currentImportance++;
        }

        long long totalImportance = 0;
        for (auto& road : roads) {
            totalImportance += importance[road[0]] + importance[road[1]];
        }

        return totalImportance;
    }
};
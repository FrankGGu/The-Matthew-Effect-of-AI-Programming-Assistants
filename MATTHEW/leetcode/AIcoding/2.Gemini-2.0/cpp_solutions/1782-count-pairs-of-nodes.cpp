#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> countPairs(int n, vector<vector<int>>& edges, vector<int>& queries) {
        vector<int> degree(n + 1, 0);
        unordered_map<int, int> edgeCount;

        for (auto& edge : edges) {
            int u = edge[0], v = edge[1];
            degree[u]++;
            degree[v]++;
            if (u > v) swap(u, v);
            edgeCount[u * (n + 1) + v]++;
        }

        vector<int> sortedDegree = degree;
        sortedDegree.erase(sortedDegree.begin());
        sort(sortedDegree.begin(), sortedDegree.end());

        vector<int> result;
        for (int query : queries) {
            int count = 0;
            for (int i = 1; i <= n; ++i) {
                for (int j = i + 1; j <= n; ++j) {
                    int sum = degree[i] + degree[j];
                    if (i > j) swap(i, j);
                    int commonEdges = edgeCount[i * (n + 1) + j];
                    if (sum - commonEdges > query) {
                        count++;
                    }
                }
            }
            result.push_back(count);
        }

        return result;
    }
};
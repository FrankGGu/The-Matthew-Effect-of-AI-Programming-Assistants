#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestPath(char c, vector<int>& parent, string& s) {
        unordered_map<int, vector<int>> graph;
        for (int i = 1; i < parent.size(); ++i) {
            graph[parent[i]].push_back(i);
        }

        int result = 0;

        function<int(int)> dfs = [&](int node) -> int {
            int max1 = 0, max2 = 0;
            for (int neighbor : graph[node]) {
                int length = dfs(neighbor);
                if (s[neighbor] != s[node]) {
                    if (length > max1) {
                        max2 = max1;
                        max1 = length;
                    } else if (length > max2) {
                        max2 = length;
                    }
                }
            }
            result = max(result, max1 + max2 + 1);
            return max1 + 1;
        };

        dfs(0);
        return result;
    }
};
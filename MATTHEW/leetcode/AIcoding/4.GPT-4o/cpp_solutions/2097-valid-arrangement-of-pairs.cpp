#include <vector>
#include <unordered_map>
#include <stack>

using namespace std;

class Solution {
public:
    vector<vector<int>> validArrangement(vector<vector<int>>& pairs) {
        unordered_map<int, int> outdegree, indegree;
        unordered_map<int, vector<int>> graph;

        for (const auto& p : pairs) {
            graph[p[0]].push_back(p[1]);
            outdegree[p[0]]++;
            indegree[p[1]]++;
        }

        int start = pairs[0][0];
        for (const auto& p : outdegree) {
            if (p.second > indegree[p.first]) {
                start = p.first;
                break;
            }
        }

        stack<int> stk;
        vector<vector<int>> result;
        stk.push(start);

        while (!stk.empty()) {
            int u = stk.top();
            if (graph[u].empty()) {
                result.push_back({u, -1}); 
                stk.pop();
            } else {
                int v = graph[u].back();
                graph[u].pop_back();
                stk.push(v);
            }
        }

        reverse(result.begin(), result.end());
        for (int i = 0; i < result.size() - 1; ++i) {
            result[i][1] = result[i + 1][0];
        }
        result.pop_back();

        return result;
    }
};
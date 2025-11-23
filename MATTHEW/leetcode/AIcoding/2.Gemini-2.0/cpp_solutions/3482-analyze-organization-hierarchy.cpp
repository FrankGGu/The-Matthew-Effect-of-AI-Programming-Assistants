#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> countSubordinates(int n, vector<vector<int>>& edges, int headID) {
        unordered_map<int, vector<int>> adj;
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
        }

        vector<int> result(n, 0);
        unordered_map<int, int> idToIndex;
        vector<int> ids;
        int index = 0;
        for (auto& edge : edges) {
            if (idToIndex.find(edge[0]) == idToIndex.end()) {
                idToIndex[edge[0]] = index++;
                ids.push_back(edge[0]);
            }
            if (idToIndex.find(edge[1]) == idToIndex.end()) {
                idToIndex[edge[1]] = index++;
                ids.push_back(edge[1]);
            }
        }

        if (idToIndex.find(headID) == idToIndex.end()) {
            idToIndex[headID] = index++;
            ids.push_back(headID);
        }

        function<int(int)> dfs = [&](int u) {
            int count = 0;
            for (int v : adj[u]) {
                count += 1 + dfs(v);
            }
            return count;
        };

        for (int i = 0; i < ids.size(); ++i) {
            result[i] = dfs(ids[i]);
        }

        vector<int> final_result(n,0);
        for(int i=0; i<ids.size(); ++i){
            final_result[idToIndex[ids[i]]] = dfs(ids[i]);
        }

        vector<int> ans(n,0);
        for(int i=0; i<n; ++i){
            ans[i] = dfs(i);
        }

        vector<int> ans_result(n, 0);
        for(int i=0; i<n; ++i){
            if (idToIndex.find(i) != idToIndex.end()) {
                ans_result[i] = dfs(i);
            }
        }

        return ans_result;
    }
};
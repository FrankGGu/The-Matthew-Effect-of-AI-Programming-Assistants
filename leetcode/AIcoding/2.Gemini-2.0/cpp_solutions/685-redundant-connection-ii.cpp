#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findRedundantDirectedConnection(vector<vector<int>>& edges) {
        int n = edges.size();
        vector<int> parent(n + 1, 0);
        vector<int> inDegree(n + 1, 0);
        int first = -1, second = -1;
        for (auto& edge : edges) {
            inDegree[edge[1]]++;
        }
        for (int i = n - 1; i >= 0; i--) {
            if (inDegree[edges[i][1]] == 2) {
                first = i;
                break;
            }
        }
        vector<int> ans;
        if (first == -1) {
            vector<int> p(n + 1, 0);
            for (int i = 0; i < n; i++) {
                int u = edges[i][0], v = edges[i][1];
                int rootU = find(u, p);
                if (rootU == v) {
                    ans = edges[i];
                    break;
                }
                p[v] = rootU;
            }
        } else {
            vector<vector<int>> tempEdges;
            for (int i = 0; i < n; i++) {
                if (i != first) {
                    tempEdges.push_back(edges[i]);
                }
            }
            vector<int> p(n + 1, 0);
            bool hasCycle = false;
            for (auto& edge : tempEdges) {
                int u = edge[0], v = edge[1];
                int rootU = find(u, p);
                if (rootU == v) {
                    hasCycle = true;
                    ans = edges[first];
                    break;
                }
                p[v] = rootU;
            }
            if (!hasCycle) {
                ans = edges[first];
            } else {
                vector<vector<int>> tempEdges2;
                for (int i = 0; i < n; i++) {
                    if (i != first) {
                        tempEdges2.push_back(edges[i]);
                    }
                }
                vector<int> p2(n + 1, 0);
                int removedEdgeIndex = -1;
                for(int i = 0; i < tempEdges2.size(); ++i){
                    int u = tempEdges2[i][0], v = tempEdges2[i][1];
                    int rootU = find(u, p2);
                    if(rootU == v){
                        removedEdgeIndex = i;
                    }
                    p2[v] = rootU;
                }

                vector<int> p3(n + 1, 0);
                bool cycle_found = false;
                for (int i = 0; i < n; i++) {
                    if(inDegree[edges[i][1]] == 2 && edges[i] != edges[first]){

                        vector<vector<int>> tempEdges3;
                        for(int j = 0; j < n; ++j){
                            if(j != i){
                                tempEdges3.push_back(edges[j]);
                            }
                        }

                        vector<int> p4(n+1, 0);
                        bool has_cycle = false;
                        for(auto& edge: tempEdges3){
                            int u = edge[0], v = edge[1];
                            int rootU = find(u, p4);

                            if(rootU == v){
                                has_cycle = true;
                            }
                            p4[v] = rootU;
                        }
                        if(!has_cycle){
                            ans = edges[i];
                            break;
                        }
                    }
                }

                if(ans.empty()){
                    for(int i = 0; i < n; ++i){
                        if(inDegree[edges[i][1]] == 2 && edges[i] != edges[first]){
                            ans = edges[i];
                            break;
                        }
                    }
                }

            }
        }
        return ans;
    }

private:
    int find(int x, vector<int>& parent) {
        if (parent[x] == 0) return x;
        return find(parent[x], parent);
    }
};
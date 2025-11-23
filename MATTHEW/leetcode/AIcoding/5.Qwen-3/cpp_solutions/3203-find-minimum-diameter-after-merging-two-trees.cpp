#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minimumDiameterAfterMerging(vector<vector<int>>& tree1, vector<vector<int>>& tree2) {
        int n1 = tree1.size();
        int n2 = tree2.size();

        vector<vector<int>> adj1(n1);
        for (int i = 0; i < n1; ++i) {
            for (int j = 0; j < tree1[i].size(); ++j) {
                adj1[i].push_back(tree1[i][j]);
                adj1[tree1[i][j]].push_back(i);
            }
        }

        vector<vector<int>> adj2(n2);
        for (int i = 0; i < n2; ++i) {
            for (int j = 0; j < tree2[i].size(); ++j) {
                adj2[i].push_back(tree2[i][j]);
                adj2[tree2[i][j]].push_back(i);
            }
        }

        auto getDiameter = [&](vector<vector<int>>& adj, int n) -> int {
            auto bfs = [&](int start) -> pair<int, int> {
                vector<int> dist(n, -1);
                dist[start] = 0;
                int maxDist = 0, farthestNode = start;
                queue<int> q;
                q.push(start);
                while (!q.empty()) {
                    int u = q.front();
                    q.pop();
                    for (int v : adj[u]) {
                        if (dist[v] == -1) {
                            dist[v] = dist[u] + 1;
                            q.push(v);
                            if (dist[v] > maxDist) {
                                maxDist = dist[v];
                                farthestNode = v;
                            }
                        }
                    }
                }
                return {maxDist, farthestNode};
            };

            int u = bfs(0).second;
            int v = bfs(u).second;
            return bfs(v).first;
        };

        int d1 = getDiameter(adj1, n1);
        int d2 = getDiameter(adj2, n2);

        int maxDepth1 = 0;
        auto dfs1 = [&](int node, int parent, int depth) -> int {
            maxDepth1 = max(maxDepth1, depth);
            for (int neighbor : adj1[node]) {
                if (neighbor != parent) {
                    dfs1(neighbor, node, depth + 1);
                }
            }
            return maxDepth1;
        };

        int maxDepth2 = 0;
        auto dfs2 = [&](int node, int parent, int depth) -> int {
            maxDepth2 = max(maxDepth2, depth);
            for (int neighbor : adj2[node]) {
                if (neighbor != parent) {
                    dfs2(neighbor, node, depth + 1);
                }
            }
            return maxDepth2;
        };

        dfs1(0, -1, 0);
        dfs2(0, -1, 0);

        int mergedDiameter = max(d1, d2, maxDepth1 + maxDepth2 + 1);
        return mergedDiameter;
    }
};
#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minJumps(vector<int>& arr, int start) {
        int n = arr.size();
        vector<int> dist(n, -1);
        dist[start] = 0;
        unordered_map<int, vector<int>> graph;

        for (int i = 0; i < n; ++i) {
            graph[arr[i]].push_back(i);
        }

        vector<int> q = {start};
        for (int i = 0; i < q.size(); ++i) {
            int node = q[i];
            if (node == 0 || node == n - 1) return dist[node];
            for (int neighbor : graph[arr[node]]) {
                if (dist[neighbor] == -1) {
                    dist[neighbor] = dist[node] + 1;
                    q.push_back(neighbor);
                }
            }
            graph[arr[node]].clear();
            if (node > 0 && dist[node - 1] == -1) {
                dist[node - 1] = dist[node] + 1;
                q.push_back(node - 1);
            }
            if (node < n - 1 && dist[node + 1] == -1) {
                dist[node + 1] = dist[node] + 1;
                q.push_back(node + 1);
            }
        }
        return -1;
    }
};
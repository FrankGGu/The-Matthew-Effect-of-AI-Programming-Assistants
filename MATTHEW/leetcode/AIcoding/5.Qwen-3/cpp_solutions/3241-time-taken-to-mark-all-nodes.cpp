#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int timeTakenToMarkAllNodes(vector<int>& parent, int n) {
        vector<vector<int>> graph(n);
        for (int i = 1; i < n; ++i) {
            graph[parent[i]].push_back(i);
        }

        vector<int> time(n, 0);
        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (parent[i] == -1) {
                q.push(i);
                break;
            }
        }

        while (!q.empty()) {
            int node = q.front();
            q.pop();
            for (int child : graph[node]) {
                time[child] = time[node] + 1;
                q.push(child);
            }
        }

        return *max_element(time.begin(), time.end());
    }
};
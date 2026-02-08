#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minTimeToBreakLocks(vector<int>& locks, int key) {
        int n = locks.size();
        vector<int> dist(n, -1);
        queue<int> q;

        for (int i = 0; i < n; ++i) {
            if (locks[i] == 0) {
                dist[i] = 0;
                q.push(i);
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int v = 0; v < n; ++v) {
                if (u != v && locks[v] == 0) continue;
                if (dist[v] == -1 || dist[v] > dist[u] + 1) {
                    dist[v] = dist[u] + 1;
                    q.push(v);
                }
            }
        }

        return dist[key];
    }
};
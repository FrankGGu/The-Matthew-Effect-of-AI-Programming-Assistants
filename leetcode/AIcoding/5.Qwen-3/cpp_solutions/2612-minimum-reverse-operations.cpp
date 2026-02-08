#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> getLeastReversals(int n, int[] restrictions) {
        vector<int> result(n, -1);
        vector<vector<int>> adj(n);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (abs(i - j) <= 2) {
                    adj[i].push_back(j);
                }
            }
        }

        queue<int> q;
        unordered_set<int> visited;

        for (int i = 0; i < n; ++i) {
            if (restrictions[i] == 0) {
                result[i] = 0;
                q.push(i);
                visited.insert(i);
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int v : adj[u]) {
                if (result[v] == -1) {
                    result[v] = result[u] + 1;
                    q.push(v);
                    visited.insert(v);
                }
            }
        }

        return result;
    }
};
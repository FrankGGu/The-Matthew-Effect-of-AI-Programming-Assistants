#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int findMinimumDiameter(vector<int>& a, vector<int>& b, vector<int>& c) {
        int n = a.size() + 1;
        vector<vector<int>> adj1(n), adj2(n);
        for (int i = 0; i < a.size(); ++i) {
            adj1[a[i]].push_back(b[i]);
            adj1[b[i]].push_back(a[i]);
        }
        for (int i = 0; i < a.size(); ++i) {
            adj2[c[i]].push_back(a[i]);
            adj2[a[i]].push_back(c[i]);
        }

        vector<int> d1 = getFarthest(adj1, 0);
        int u1 = max_element(d1.begin(), d1.end()) - d1.begin();
        d1 = getFarthest(adj1, u1);
        int v1 = max_element(d1.begin(), d1.end()) - d1.begin();
        vector<int> d1_v1 = getFarthest(adj1, v1);

        vector<int> d2 = getFarthest(adj2, 0);
        int u2 = max_element(d2.begin(), d2.end()) - d2.begin();
        d2 = getFarthest(adj2, u2);
        int v2 = max_element(d2.begin(), d2.end()) - d2.begin();
        vector<int> d2_v2 = getFarthest(adj2, v2);

        int min_diameter = INT_MAX;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                int current_max = max({(d1[i] + d2[j] + 1) / 2, (d1_v1[i] + d2_v2[j] + 1) / 2});
                current_max = max(current_max, max(d1[i], d1_v1[i]));
                current_max = max(current_max, max(d2[j], d2_v2[j]));
                min_diameter = min(min_diameter, current_max);
            }
        }
        return min_diameter;
    }

private:
    vector<int> getFarthest(const vector<vector<int>>& adj, int start) {
        int n = adj.size();
        vector<int> dist(n, -1);
        dist[start] = 0;
        vector<int> q = {start};
        for (int i = 0; i < q.size(); ++i) {
            int u = q[i];
            for (int v : adj[u]) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    q.push_back(v);
                }
            }
        }
        return dist;
    }
};
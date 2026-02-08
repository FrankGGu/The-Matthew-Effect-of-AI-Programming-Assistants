#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int closestMeetingNode(vector<int>& edges, int node1, int node2) {
        int n = edges.size();
        vector<int> dist1(n, -1);
        vector<int> dist2(n, -1);

        queue<int> q1;
        q1.push(node1);
        dist1[node1] = 0;

        while (!q1.empty()) {
            int u = q1.front();
            q1.pop();

            if (edges[u] != -1 && dist1[edges[u]] == -1) {
                dist1[edges[u]] = dist1[u] + 1;
                q1.push(edges[u]);
            }
        }

        queue<int> q2;
        q2.push(node2);
        dist2[node2] = 0;

        while (!q2.empty()) {
            int u = q2.front();
            q2.pop();

            if (edges[u] != -1 && dist2[edges[u]] == -1) {
                dist2[edges[u]] = dist2[u] + 1;
                q2.push(edges[u]);
            }
        }

        int minDist = INT_MAX;
        int result = -1;

        for (int i = 0; i < n; ++i) {
            if (dist1[i] != -1 && dist2[i] != -1) {
                int maxDist = max(dist1[i], dist2[i]);
                if (maxDist < minDist) {
                    minDist = maxDist;
                    result = i;
                }
            }
        }

        return result;
    }
};
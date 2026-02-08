#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestCycle(int n, vector<int>& edges) {
        vector<int> visited(n, 0);
        int ans = -1;
        for (int i = 0; i < n; ++i) {
            if (visited[i] == 0) {
                vector<int> path(n, -1);
                int curr = i;
                int count = 1;
                while (curr != -1 && visited[curr] == 0) {
                    visited[curr] = 1;
                    path[curr] = count;
                    curr = edges[curr];
                    count++;
                }
                if (curr != -1 && path[curr] != -1) {
                    ans = max(ans, count - path[curr]);
                }
            }
        }
        return ans;
    }
};
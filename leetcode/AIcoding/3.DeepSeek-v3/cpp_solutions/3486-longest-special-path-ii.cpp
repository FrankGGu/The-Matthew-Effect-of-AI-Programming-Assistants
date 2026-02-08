#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>
#include <functional>

using namespace std;

class Solution {
public:
    int longestCycle(vector<int>& edges) {
        int n = edges.size();
        vector<int> visited(n, 0);
        int max_cycle = -1;

        for (int i = 0; i < n; ++i) {
            if (visited[i] == 0) {
                unordered_map<int, int> path;
                int current = i;
                int step = 1;
                while (current != -1) {
                    if (path.count(current)) {
                        max_cycle = max(max_cycle, step - path[current]);
                        break;
                    }
                    if (visited[current] == 1) break;
                    path[current] = step++;
                    visited[current] = 1;
                    current = edges[current];
                }
            }
        }
        return max_cycle;
    }
};
#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> countVisitedNodes(vector<int>& headID) {
        int n = headID.size();
        vector<int> visited(n, 0);
        vector<bool> processed(n, false);

        for (int i = 0; i < n; ++i) {
            if (!processed[i]) {
                stack<int> path;
                int current = i;
                while (true) {
                    if (processed[current]) {
                        int cnt = 0;
                        while (!path.empty()) {
                            int node = path.top();
                            path.pop();
                            visited[node] = cnt++;
                        }
                        break;
                    }
                    if (visited[current] != 0) {
                        int cnt = visited[current];
                        while (!path.empty()) {
                            int node = path.top();
                            path.pop();
                            visited[node] = cnt++;
                        }
                        break;
                    }
                    processed[current] = true;
                    path.push(current);
                    current = headID[current];
                }
            }
        }
        return visited;
    }
};
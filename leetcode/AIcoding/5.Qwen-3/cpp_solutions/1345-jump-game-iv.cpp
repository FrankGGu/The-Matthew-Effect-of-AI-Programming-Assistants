#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minJumps(vector<int>& arr) {
        int n = arr.size();
        if (n == 1) return 0;

        unordered_map<int, vector<int>> graph;
        for (int i = 0; i < n; ++i) {
            graph[arr[i]].push_back(i);
        }

        queue<int> q;
        q.push(0);
        unordered_set<int> visited;
        visited.insert(0);

        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int index = q.front();
                q.pop();

                if (index == n - 1) return steps;

                for (int neighbor : graph[arr[index]]) {
                    if (visited.find(neighbor) == visited.end()) {
                        visited.insert(neighbor);
                        q.push(neighbor);
                    }
                }

                graph[arr[index]].clear();

                if (index + 1 < n && visited.find(index + 1) == visited.end()) {
                    visited.insert(index + 1);
                    q.push(index + 1);
                }

                if (index - 1 >= 0 && visited.find(index - 1) == visited.end()) {
                    visited.insert(index - 1);
                    q.push(index - 1);
                }
            }
            ++steps;
        }

        return -1;
    }
};
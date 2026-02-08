#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumOperations(vector<int>& root) {
        vector<vector<int>> levels;
        queue<int> q;
        q.push(0);
        vector<bool> visited(root.size(), false);
        while (!q.empty()) {
            int levelSize = q.size();
            vector<int> level;
            for (int i = 0; i < levelSize; ++i) {
                int node = q.front();
                q.pop();
                if (visited[node]) continue;
                visited[node] = true;
                level.push_back(root[node]);
                int left = 2 * node + 1;
                int right = 2 * node + 2;
                if (left < root.size()) q.push(left);
                if (right < root.size()) q.push(right);
            }
            if (!level.empty()) levels.push_back(level);
        }

        int operations = 0;
        for (auto& level : levels) {
            vector<int> sortedLevel = level;
            sort(sortedLevel.begin(), sortedLevel.end());
            vector<int> original = level;
            vector<int> indices(root.size(), -1);
            for (int i = 0; i < sortedLevel.size(); ++i) {
                indices[sortedLevel[i]] = i;
            }
            int cycleCount = 0;
            for (int i = 0; i < original.size(); ++i) {
                if (original[i] != sortedLevel[i]) {
                    int j = i;
                    while (original[j] != sortedLevel[i]) {
                        j = indices[original[j]];
                        cycleCount++;
                    }
                    cycleCount++;
                }
            }
            operations += cycleCount / 2;
        }
        return operations;
    }
};
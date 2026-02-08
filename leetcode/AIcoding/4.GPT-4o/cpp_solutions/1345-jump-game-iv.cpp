#include <vector>
#include <unordered_map>
#include <queue>

class Solution {
public:
    int minJumps(std::vector<int>& arr) {
        int n = arr.size();
        if (n <= 1) return 0;

        std::unordered_map<int, std::vector<int>> graph;
        for (int i = 0; i < n; ++i) {
            graph[arr[i]].push_back(i);
        }

        std::vector<bool> visited(n, false);
        std::queue<int> q;
        q.push(0);
        visited[0] = true;
        int jumps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int idx = q.front();
                q.pop();
                if (idx == n - 1) return jumps;

                std::vector<int>& nextIndices = graph[arr[idx]];
                nextIndices.push_back(idx - 1);
                nextIndices.push_back(idx + 1);

                for (int nextIdx : nextIndices) {
                    if (nextIdx >= 0 && nextIdx < n && !visited[nextIdx]) {
                        visited[nextIdx] = true;
                        q.push(nextIdx);
                    }
                }
                nextIndices.clear();
            }
            jumps++;
        }
        return -1;
    }
};
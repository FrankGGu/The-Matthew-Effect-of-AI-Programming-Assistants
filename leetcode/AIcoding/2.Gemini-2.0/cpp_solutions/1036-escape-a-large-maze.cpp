#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool isEscapePossible(vector<vector<int>>& blocked, vector<int>& source, vector<int>& target) {
        unordered_set<long long> blockedSet;
        for (auto& b : blocked) {
            blockedSet.insert((long long)b[0] * 1000000 + b[1]);
        }

        function<bool(vector<int>&, vector<int>&, unordered_set<long long>&)> bfs = 
            [&](vector<int>& start, vector<int>& end, unordered_set<long long>& blockedSet) {
            queue<vector<int>> q;
            q.push(start);
            unordered_set<long long> visited;
            visited.insert((long long)start[0] * 1000000 + start[1]);
            int count = 0;

            while (!q.empty()) {
                vector<int> curr = q.front();
                q.pop();
                count++;

                if (curr[0] == end[0] && curr[1] == end[1]) {
                    return true;
                }

                if (count > 20000) return true;

                int dx[] = {0, 0, 1, -1};
                int dy[] = {1, -1, 0, 0};

                for (int i = 0; i < 4; ++i) {
                    int nx = curr[0] + dx[i];
                    int ny = curr[1] + dy[i];

                    if (nx >= 0 && nx < 1000000 && ny >= 0 && ny < 1000000) {
                        long long nextPos = (long long)nx * 1000000 + ny;
                        if (blockedSet.find(nextPos) == blockedSet.end() && visited.find(nextPos) == visited.end()) {
                            q.push({nx, ny});
                            visited.insert(nextPos);
                        }
                    }
                }
            }
            return false;
        };

        return bfs(source, target, blockedSet) && bfs(target, source, blockedSet);
    }
};
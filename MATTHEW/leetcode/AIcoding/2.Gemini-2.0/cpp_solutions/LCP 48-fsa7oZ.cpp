#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minKnightMoves(int x, int y) {
        x = abs(x);
        y = abs(y);

        queue<pair<int, int>> q;
        q.push({0, 0});

        unordered_set<long long> visited;
        visited.insert(0);

        int steps = 0;
        int dx[] = {1, 1, 2, 2, -1, -1, -2, -2};
        int dy[] = {2, -2, 1, -1, 2, -2, 1, -1};

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int currX = q.front().first;
                int currY = q.front().second;
                q.pop();

                if (currX == x && currY == y) {
                    return steps;
                }

                for (int j = 0; j < 8; ++j) {
                    int nextX = currX + dx[j];
                    int nextY = currY + dy[j];

                    if (nextX >= -1 && nextY >= -1) {
                        long long key = (long long)nextX * 1000 + nextY;
                        if (visited.find(key) == visited.end()) {
                            q.push({nextX, nextY});
                            visited.insert(key);
                        }
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};
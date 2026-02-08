#include <queue>
#include <vector>

using namespace std;

class Solution {
public:
    int racecar(int target) {
        queue<pair<int, int>> q;
        q.push({0, 1});

        vector<vector<bool>> visited(2 * target + 1, vector<bool>(2));
        visited[0][1] = true;

        int steps = 0;
        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int pos = q.front().first;
                int speed = q.front().second;
                q.pop();

                if (pos == target) {
                    return steps;
                }

                int newPosA = pos + speed;
                int newSpeedA = speed * 2;

                if (newPosA >= 0 && newPosA <= 2 * target && !visited[newPosA][newSpeedA > 0]) {
                    q.push({newPosA, newSpeedA});
                    visited[newPosA][newSpeedA > 0] = true;
                }

                int newSpeedR = (speed > 0) ? -1 : 1;
                if (!visited[pos][newSpeedR > 0]) {
                    q.push({pos, newSpeedR});
                    visited[pos][newSpeedR > 0] = true;
                }
            }
            ++steps;
        }
        return -1;
    }
};
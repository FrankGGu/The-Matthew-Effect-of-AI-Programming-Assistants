#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int racecar(int target) {
        queue<pair<int, int>> q;
        q.push({0, 1});
        vector<vector<bool>> visited(target * 2 + 1, vector<bool>(target * 2 + 1, false));
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

                int next_pos_a = pos + speed;
                int next_speed_a = speed * 2;
                if (abs(next_pos_a) <= target * 2 && abs(next_speed_a) <= target * 2 && !visited[next_pos_a + target][next_speed_a + target]) {
                    q.push({next_pos_a, next_speed_a});
                    visited[next_pos_a + target][next_speed_a + target] = true;
                }

                int next_speed_r = (speed > 0) ? -1 : 1;
                if (abs(pos) <= target * 2 && abs(next_speed_r) <= target * 2 && !visited[pos + target][next_speed_r + target]) {
                    q.push({pos, next_speed_r});
                    visited[pos + target][next_speed_r + target] = true;
                }
            }
            steps++;
        }

        return -1;
    }
};
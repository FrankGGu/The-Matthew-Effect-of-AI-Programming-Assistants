#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int raceCar(int target) {
        queue<pair<int, int>> q;
        q.push({0, 0});
        unordered_set<string> visited;
        visited.insert("0,0");

        while (!q.empty()) {
            auto [pos, speed] = q.front();
            q.pop();

            if (pos == target) {
                return speed;
            }

                        int newPos = pos + speed;
            int newSpeed = speed * 2;
            string key = to_string(newPos) + "," + to_string(newSpeed);
            if (newPos >= 0 && newPos <= 2 * target && visited.find(key) == visited.end()) {
                visited.insert(key);
                q.push({newPos, newSpeed});
            }

                        newPos = pos;
            newSpeed = -1;
            if (speed > 0) {
                newSpeed = -1;
            } else {
                newSpeed = 1;
            }
            key = to_string(newPos) + "," + to_string(newSpeed);
            if (newPos >= 0 && newPos <= 2 * target && visited.find(key) == visited.end()) {
                visited.insert(key);
                q.push({newPos, newSpeed});
            }
        }

        return -1;
    }
};
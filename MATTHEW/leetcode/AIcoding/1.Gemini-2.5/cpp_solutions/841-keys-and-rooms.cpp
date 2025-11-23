#include <vector>
#include <queue>

class Solution {
public:
    bool canVisitAllRooms(std::vector<std::vector<int>>& rooms) {
        int n = rooms.size();
        if (n == 0) {
            return true;
        }

        std::vector<bool> visited(n, false);
        std::queue<int> q;
        int visited_count = 0;

        q.push(0);
        visited[0] = true;
        visited_count++;

        while (!q.empty()) {
            int current_room = q.front();
            q.pop();

            for (int key : rooms[current_room]) {
                if (!visited[key]) {
                    visited[key] = true;
                    visited_count++;
                    q.push(key);
                }
            }
        }

        return visited_count == n;
    }
};
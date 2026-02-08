#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool canVisitAllRooms(vector<vector<int>>& rooms) {
        int n = rooms.size();
        vector<bool> visited(n, false);
        queue<int> q;
        q.push(0);
        visited[0] = true;
        int count = 0;

        while (!q.empty()) {
            int room = q.front();
            q.pop();
            count++;

            for (int key : rooms[room]) {
                if (!visited[key]) {
                    visited[key] = true;
                    q.push(key);
                }
            }
        }

        return count == n;
    }
};
class Solution {
public:
    bool canVisitAllRooms(vector<vector<int>>& rooms) {
        int n = rooms.size();
        vector<bool> visited(n, false);
        queue<int> q;
        q.push(0);
        visited[0] = true;
        int count = 1;

        while (!q.empty()) {
            int current = q.front();
            q.pop();
            for (int key : rooms[current]) {
                if (!visited[key]) {
                    visited[key] = true;
                    q.push(key);
                    count++;
                }
            }
        }

        return count == n;
    }
};
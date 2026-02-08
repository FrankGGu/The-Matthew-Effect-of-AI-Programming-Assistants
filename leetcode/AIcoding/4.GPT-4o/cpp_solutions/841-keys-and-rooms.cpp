class Solution {
public:
    bool canVisitAllRooms(vector<vector<int>>& rooms) {
        int n = rooms.size();
        vector<bool> visited(n, false);
        stack<int> stk;
        stk.push(0);
        visited[0] = true;

        while (!stk.empty()) {
            int room = stk.top();
            stk.pop();
            for (int key : rooms[room]) {
                if (!visited[key]) {
                    visited[key] = true;
                    stk.push(key);
                }
            }
        }

        for (bool v : visited) {
            if (!v) return false;
        }
        return true;
    }
};
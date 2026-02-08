#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    bool canVisitAllRooms(vector<vector<int>>& rooms) {
        vector<bool> visited(rooms.size(), false);
        stack<int> s;
        s.push(0);
        visited[0] = true;

        int count = 1;

        while (!s.empty()) {
            int current = s.top();
            s.pop();

            for (int key : rooms[current]) {
                if (!visited[key]) {
                    visited[key] = true;
                    s.push(key);
                    count++;
                }
            }
        }

        return count == rooms.size();
    }
};
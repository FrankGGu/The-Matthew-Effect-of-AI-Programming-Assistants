#include <vector>
#include <queue>
#include <unordered_set>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int cleanRoom(vector<vector<int>>& room) {
        m = room.size();
        n = room[0].size();
        visited.clear();
        int res = 0;
        dfs(room, 0, 0, 0, res);
        return res;
    }

private:
    int m, n;
    unordered_set<string> visited;
    vector<vector<int>> dirs = {{-1, 0}, {0, 1}, {1, 0}, {0, -1}};

    void dfs(vector<vector<int>>& room, int x, int y, int dir, int& res) {
        string key = to_string(x) + "," + to_string(y) + "," + to_string(dir);
        if (visited.count(key)) return;
        visited.insert(key);

        for (int i = 0; i < 4; ++i) {
            int ndir = (dir + i) % 4;
            int nx = x + dirs[ndir][0];
            int ny = y + dirs[ndir][1];

            if (nx >= 0 && nx < m && ny >= 0 && ny < n && room[nx][ny] != 1) {
                res++;
                dfs(room, nx, ny, ndir, res);
                res++;
                moveBack();
            } else {
                res++;
                turnRight();
            }
        }
    }

    void moveBack() {
        return;
    }

    void turnRight() {
        return;
    }
};
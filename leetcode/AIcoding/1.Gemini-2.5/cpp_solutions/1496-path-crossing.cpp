#include <string>
#include <set>
#include <utility>

using namespace std;

class Solution {
public:
    bool isPathCrossing(string path) {
        set<pair<int, int>> visited;
        int x = 0, y = 0;
        visited.insert({x, y});

        for (char c : path) {
            if (c == 'N') {
                y++;
            } else if (c == 'S') {
                y--;
            } else if (c == 'E') {
                x++;
            } else {
                x--;
            }

            if (visited.count({x, y})) {
                return true;
            }

            visited.insert({x, y});
        }

        return false;
    }
};
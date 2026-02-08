#include <string>
#include <unordered_set>
#include <utility>

using namespace std;

class Solution {
public:
    bool isPathCrossing(string path) {
        unordered_set<pair<int, int>, HashPair> visited;
        int x = 0, y = 0;
        visited.insert({0, 0});

        for (char move : path) {
            if (move == 'N') {
                y++;
            } else if (move == 'S') {
                y--;
            } else if (move == 'E') {
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

private:
    struct HashPair {
        size_t operator()(const pair<int, int>& p) const {
            return hash<int>()(p.first) ^ hash<int>()(p.second);
        }
    };
};
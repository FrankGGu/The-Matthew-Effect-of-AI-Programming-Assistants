#include <iostream>
#include <vector>
#include <unordered_set>
#include <string>

using namespace std;

class Solution {
public:
    bool isPathCrossing(string path) {
        int x = 0, y = 0;
        unordered_set<string> visited;
        visited.insert("0,0");

        for (char c : path) {
            if (c == 'U') y++;
            else if (c == 'D') y--;
            else if (c == 'R') x++;
            else if (c == 'L') x--;

            string key = to_string(x) + "," + to_string(y);
            if (visited.find(key) != visited.end()) {
                return true;
            }
            visited.insert(key);
        }

        return false;
    }
};
#include <iostream>
#include <vector>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    string alphabetBoardPath(string target) {
        string res;
        int x = 0, y = 0;
        for (char c : target) {
            int nx = (c - 'a') / 6;
            int ny = (c - 'a') % 6;
            while (y > ny) res += 'U', y--;
            while (x > nx) res += 'L', x--;
            while (y < ny) res += 'D', y++;
            while (x < nx) res += 'R', x++;
            res += '!';
        }
        return res;
    }
};
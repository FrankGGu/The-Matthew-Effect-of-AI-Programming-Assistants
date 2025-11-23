#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    bool escapeGhosts(vector<int>& pacman, vector<int>& ghosts) {
        int pacmanDistance = abs(pacman[0]) + abs(pacman[1]);
        for (int i = 0; i < ghosts.size(); i++) {
            int ghostDistance = abs(ghosts[i][0]) + abs(ghosts[i][1]);
            if (ghostDistance <= pacmanDistance) {
                return false;
            }
        }
        return true;
    }
};
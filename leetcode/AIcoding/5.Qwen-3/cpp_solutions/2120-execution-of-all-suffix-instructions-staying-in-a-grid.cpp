#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> executeInstructions(int n, vector<int>& startPos, string s) {
        int m = s.length();
        vector<int> result(m, 0);
        for (int i = 0; i < m; ++i) {
            int x = startPos[0], y = startPos[1];
            int count = 0;
            for (int j = i; j < m; ++j) {
                char dir = s[j];
                if (dir == 'U') x--;
                else if (dir == 'D') x++;
                else if (dir == 'L') y--;
                else if (dir == 'R') y++;
                if (x < 0 || x >= n || y < 0 || y >= n) break;
                count++;
            }
            result[i] = count;
        }
        return result;
    }
};
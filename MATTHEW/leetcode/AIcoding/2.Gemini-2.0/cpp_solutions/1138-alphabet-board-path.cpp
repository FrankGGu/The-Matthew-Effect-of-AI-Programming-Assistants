#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string alphabetBoardPath(string target) {
        vector<pair<int, int>> pos(26);
        for (int i = 0; i < 26; ++i) {
            pos[i] = {i / 5, i % 5};
        }

        string res = "";
        int cur_x = 0, cur_y = 0;
        for (char c : target) {
            int idx = c - 'a';
            int target_x = pos[idx].first;
            int target_y = pos[idx].second;

            while (cur_x > target_x) {
                res += 'U';
                cur_x--;
            }
            while (cur_y > target_y) {
                res += 'L';
                cur_y--;
            }
            while (cur_x < target_x) {
                res += 'D';
                cur_x++;
            }
            while (cur_y < target_y) {
                res += 'R';
                cur_y++;
            }

            res += '!';
        }
        return res;
    }
};
#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    vector<string> cellsInRange(string s) {
        char col1 = s[0];
        char col2 = s[3];
        int row1 = stoi(s.substr(1, 1));
        int row2 = stoi(s.substr(4, 1));
        if (s[2] == ':') {
            row1 = stoi(s.substr(1, s.find(':') - 1));
            row2 = stoi(s.substr(s.find(':') + 2));
        }

        vector<string> res;
        for (char c = col1; c <= col2; ++c) {
            for (int r = row1; r <= row2; ++r) {
                res.push_back(string(1, c) + to_string(r));
            }
        }
        return res;
    }
};
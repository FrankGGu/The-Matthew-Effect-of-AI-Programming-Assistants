#include <iostream>
#include <vector>
#include <string>
#include <map>

using namespace std;

class Solution {
public:
    string originalDigits(string s) {
        vector<int> count(10, 0);
        map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

                count[0] = freq['z'];
        freq['e'] -= count[0];
        freq['r'] -= count[0];
        freq['o'] -= count[0];

                count[2] = freq['w'];
        freq['t'] -= count[2];
        freq['o'] -= count[2];

                count[4] = freq['u'];
        freq['f'] -= count[4];
        freq['r'] -= count[4];
        freq['o'] -= count[4];
        freq['u'] -= count[4];

                count[6] = freq['x'];
        freq['s'] -= count[6];
        freq['i'] -= count[6];

                count[8] = freq['g'];
        freq['e'] -= count[8];
        freq['i'] -= count[8];
        freq['h'] -= count[8];
        freq['t'] -= count[8];

                count[1] = freq['o'];
        freq['o'] -= count[1];
        freq['n'] -= count[1];
        freq['e'] -= count[1];

                count[3] = freq['h'];
        freq['t'] -= count[3];
        freq['r'] -= count[3];
        freq['e'] -= count[3];
        freq['e'] -= count[3];

                count[5] = freq['f'];
        freq['f'] -= count[5];
        freq['i'] -= count[5];
        freq['v'] -= count[5];
        freq['e'] -= count[5];

                count[7] = freq['s'];
        freq['s'] -= count[7];
        freq['e'] -= count[7];
        freq['v'] -= count[7];
        freq['n'] -= count[7];

                count[9] = freq['i'];
        freq['n'] -= count[9];
        freq['i'] -= count[9];
        freq['e'] -= count[9];
        freq['n'] -= count[9];

        string result;
        for (int i = 0; i <= 9; ++i) {
            for (int j = 0; j < count[i]; ++j) {
                result += to_string(i);
            }
        }
        return result;
    }
};
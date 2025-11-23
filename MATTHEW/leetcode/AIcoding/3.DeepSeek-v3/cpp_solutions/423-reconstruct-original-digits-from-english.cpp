#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    string originalDigits(string s) {
        vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'a']++;
        }

        vector<int> num(10, 0);
        num[0] = count['z' - 'a'];
        num[2] = count['w' - 'a'];
        num[4] = count['u' - 'a'];
        num[6] = count['x' - 'a'];
        num[8] = count['g' - 'a'];
        num[3] = count['h' - 'a'] - num[8];
        num[5] = count['f' - 'a'] - num[4];
        num[7] = count['s' - 'a'] - num[6];
        num[1] = count['o' - 'a'] - num[0] - num[2] - num[4];
        num[9] = count['i' - 'a'] - num[5] - num[6] - num[8];

        string res;
        for (int i = 0; i < 10; i++) {
            res.append(num[i], '0' + i);
        }
        return res;
    }
};
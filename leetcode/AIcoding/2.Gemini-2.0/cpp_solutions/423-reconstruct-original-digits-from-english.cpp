#include <string>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    string originalDigits(string s) {
        vector<int> counts(26, 0);
        for (char c : s) {
            counts[c - 'a']++;
        }

        vector<int> digits(10, 0);

        digits[0] = counts['z' - 'a'];
        digits[2] = counts['w' - 'a'];
        digits[4] = counts['u' - 'a'];
        digits[6] = counts['x' - 'a'];
        digits[8] = counts['g' - 'a'];

        digits[1] = counts['o' - 'a'] - digits[0] - digits[2] - digits[4];
        digits[3] = counts['h' - 'a'] - digits[8];
        digits[5] = counts['f' - 'a'] - digits[4];
        digits[7] = counts['v' - 'a'] - digits[5];
        digits[9] = counts['i' - 'a'] - digits[5] - digits[6] - digits[8];

        string result = "";
        for (int i = 0; i < 10; ++i) {
            result += string(digits[i], '0' + i);
        }

        sort(result.begin(), result.end());

        return result;
    }
};
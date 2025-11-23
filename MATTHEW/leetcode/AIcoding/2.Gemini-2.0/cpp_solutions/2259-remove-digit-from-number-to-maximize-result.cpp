#include <string>

using namespace std;

class Solution {
public:
    string removeDigit(string number, char digit) {
        string ans = "";
        int n = number.length();
        int last_index = -1;

        for (int i = 0; i < n; ++i) {
            if (number[i] == digit) {
                last_index = i;
                string temp = number.substr(0, i) + number.substr(i + 1);
                if (ans == "" || temp > ans) {
                    ans = temp;
                }
            }
        }

        return ans;
    }
};
#include <string>
#include <algorithm>
#include <vector>

using namespace std;

class Solution {
public:
    string makeLargestSpecial(string s) {
        int count = 0;
        int left = 0;
        vector<string> subs;
        for (int i = 0; i < s.length(); ++i) {
            if (s[i] == '1') {
                count++;
            } else {
                count--;
            }
            if (count == 0) {
                subs.push_back("1" + makeLargestSpecial(s.substr(left + 1, i - left - 1)) + "0");
                left = i + 1;
            }
        }
        sort(subs.begin(), subs.end(), greater<string>());
        string res = "";
        for (const string& sub : subs) {
            res += sub;
        }
        return res;
    }
};
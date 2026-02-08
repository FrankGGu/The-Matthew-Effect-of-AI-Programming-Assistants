#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> ambiguousCoordinates(string s) {
        s = s.substr(1, s.size() - 2);
        vector<string> res;
        for (int i = 1; i < s.size(); ++i) {
            string s1 = s.substr(0, i);
            string s2 = s.substr(i);
            vector<string> v1 = getValid(s1);
            vector<string> v2 = getValid(s2);
            for (string str1 : v1) {
                for (string str2 : v2) {
                    res.push_back("(" + str1 + ", " + str2 + ")");
                }
            }
        }
        return res;
    }

private:
    vector<string> getValid(string s) {
        vector<string> res;
        if (s.size() == 1 || s[0] != '0') {
            res.push_back(s);
        }
        for (int i = 1; i < s.size(); ++i) {
            string s1 = s.substr(0, i);
            string s2 = s.substr(i);
            if (s1.size() > 1 && s1[0] == '0') continue;
            if (s2.back() == '0') continue;
            res.push_back(s1 + "." + s2);
        }
        return res;
    }
};
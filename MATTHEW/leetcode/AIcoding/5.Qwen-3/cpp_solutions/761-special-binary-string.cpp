#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string split(string s) {
        int count = 0;
        for (int i = 0; i < s.length(); ++i) {
            if (s[i] == '1') ++count;
            else --count;
            if (count == 0) {
                string left = s.substr(0, i + 1);
                string right = s.substr(i + 1);
                string sub = split(right);
                return left + sub;
            }
        }
        return s;
    }

    string specialBinaryString(string s) {
        int count = 0;
        vector<string> res;
        for (int i = 0; i < s.length(); ++i) {
            if (s[i] == '1') ++count;
            else --count;
            if (count == 0) {
                string sub = s.substr(0, i + 1);
                string sortedSub = specialBinaryString(sub.substr(1, i));
                res.push_back('1' + sortedSub + '0');
                s = s.substr(i + 1);
                i = -1;
                count = 0;
            }
        }
        sort(res.begin(), res.end());
        string result;
        for (const string& str : res) {
            result += str;
        }
        return result;
    }
};
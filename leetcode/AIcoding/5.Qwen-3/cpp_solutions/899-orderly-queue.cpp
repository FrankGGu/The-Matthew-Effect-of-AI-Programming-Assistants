#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string orderlyQueue(string s, int k) {
        if (k == 0) return s;
        if (k > 1) return string(s.begin(), s.end());
        string res = s;
        for (int i = 1; i < s.size(); ++i) {
            if (s.substr(i) + s.substr(0, i) < res) {
                res = s.substr(i) + s.substr(0, i);
            }
        }
        return res;
    }
};
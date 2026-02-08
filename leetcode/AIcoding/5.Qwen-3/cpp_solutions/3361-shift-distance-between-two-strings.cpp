#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int shiftDistance(string s, string t) {
        vector<int> pos[26];
        for (int i = 0; i < s.size(); ++i) {
            pos[s[i] - 'a'].push_back(i);
        }
        int res = 0;
        for (int i = 0; i < t.size(); ++i) {
            int c = t[i] - 'a';
            int idx = pos[c].back();
            pos[c].pop_back();
            res += abs(i - idx);
        }
        return res;
    }
};
#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool areAlmostEqual(string s, string t) {
        vector<int> diff;
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] != t[i]) {
                diff.push_back(i);
            }
        }
        return diff.size() == 2 && s[diff[0]] == t[diff[1]] && s[diff[1]] == t[diff[0]];
    }
};
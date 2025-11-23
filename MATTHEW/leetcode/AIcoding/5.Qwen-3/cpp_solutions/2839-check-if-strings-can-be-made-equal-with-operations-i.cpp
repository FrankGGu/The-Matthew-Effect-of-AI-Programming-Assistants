#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool canBeEqual(string s1, string s2) {
        if (s1.length() != s2.length()) return false;
        vector<int> count1(26, 0);
        vector<int> count2(26, 0);
        for (int i = 0; i < s1.length(); ++i) {
            count1[s1[i] - 'a']++;
            count2[s2[i] - 'a']++;
        }
        for (int i = 0; i < 26; ++i) {
            if (count1[i] != count2[i]) return false;
        }
        return true;
    }
};
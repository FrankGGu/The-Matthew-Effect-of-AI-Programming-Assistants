#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool canBeEqual(string s1, string s2) {
        if (s1.length() != s2.length()) return false;
        vector<int> count(26, 0);
        for (char c : s1) {
            count[c - 'a']++;
        }
        for (char c : s2) {
            count[c - 'a']--;
        }
        for (int i = 0; i < 26; i++) {
            if (count[i] != 0) return false;
        }
        return true;
    }
};
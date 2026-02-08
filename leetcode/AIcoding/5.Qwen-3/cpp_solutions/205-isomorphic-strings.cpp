#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool isIsomorphic(string s, string t) {
        if (s.length() != t.length()) {
            return false;
        }
        unordered_map<char, char> map1;
        unordered_map<char, char> map2;
        for (int i = 0; i < s.length(); ++i) {
            char charS = s[i];
            char charT = t[i];
            if (map1.find(charS) != map1.end()) {
                if (map1[charS] != charT) {
                    return false;
                }
            } else {
                if (map2.find(charT) != map2.end()) {
                    return false;
                }
                map1[charS] = charT;
                map2[charT] = charS;
            }
        }
        return true;
    }
};
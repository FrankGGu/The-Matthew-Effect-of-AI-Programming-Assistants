#include <unordered_map>
#include <string>

class Solution {
public:
    bool isIsomorphic(std::string s, std::string t) {
        if (s.length() != t.length()) return false;
        std::unordered_map<char, char> mapST, mapTS;

        for (int i = 0; i < s.length(); ++i) {
            if (mapST.count(s[i]) && mapST[s[i]] != t[i]) return false;
            if (mapTS.count(t[i]) && mapTS[t[i]] != s[i]) return false;
            mapST[s[i]] = t[i];
            mapTS[t[i]] = s[i];
        }
        return true;
    }
};
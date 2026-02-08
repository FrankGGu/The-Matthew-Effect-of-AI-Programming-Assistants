#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool isIsomorphic(string s, string t) {
        if (s.length() != t.length()) {
            return false;
        }

        unordered_map<char, char> s_to_t;
        unordered_map<char, char> t_to_s;

        for (int i = 0; i < s.length(); ++i) {
            char s_char = s[i];
            char t_char = t[i];

            if (s_to_t.find(s_char) == s_to_t.end() && t_to_s.find(t_char) == t_to_s.end()) {
                s_to_t[s_char] = t_char;
                t_to_s[t_char] = s_char;
            } else if (s_to_t.find(s_char) != s_to_t.end() && t_to_s.find(t_char) != t_to_s.end()) {
                if (s_to_t[s_char] != t_char || t_to_s[t_char] != s_char) {
                    return false;
                }
            } else {
                return false;
            }
        }

        return true;
    }
};
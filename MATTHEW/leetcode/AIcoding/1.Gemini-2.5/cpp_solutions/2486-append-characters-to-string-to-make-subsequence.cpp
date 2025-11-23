class Solution {
public:
    int appendCharacters(string s, string t) {
        int s_ptr = 0;
        int t_ptr = 0;

        while (s_ptr < s.length() && t_ptr < t.length()) {
            if (s[s_ptr] == t[t_ptr]) {
                t_ptr++;
            }
            s_ptr++;
        }

        return t.length() - t_ptr;
    }
};
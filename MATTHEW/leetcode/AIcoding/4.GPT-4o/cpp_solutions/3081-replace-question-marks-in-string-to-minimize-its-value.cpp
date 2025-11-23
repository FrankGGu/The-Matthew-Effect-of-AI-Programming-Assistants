class Solution {
public:
    string minimizeString(string s) {
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] == '?') {
                char replacement = 'a';
                while (i > 0 && s[i - 1] == replacement) {
                    replacement++;
                }
                if (i < s.size() - 1 && s[i + 1] == replacement) {
                    replacement++;
                }
                s[i] = replacement;
            }
        }
        return s;
    }
};
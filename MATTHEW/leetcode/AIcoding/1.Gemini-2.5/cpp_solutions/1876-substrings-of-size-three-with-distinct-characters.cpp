class Solution {
public:
    int countGoodSubstrings(std::string s) {
        int count = 0;
        if (s.length() < 3) {
            return 0;
        }

        for (int i = 0; i <= s.length() - 3; ++i) {
            char c1 = s[i];
            char c2 = s[i+1];
            char c3 = s[i+2];

            if (c1 != c2 && c1 != c3 && c2 != c3) {
                count++;
            }
        }
        return count;
    }
};
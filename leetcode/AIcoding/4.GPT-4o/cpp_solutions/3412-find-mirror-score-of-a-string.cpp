class Solution {
public:
    int mirrorScore(string s) {
        int n = s.size();
        int score = 0;
        for (int i = 0; i < n; ++i) {
            if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u') {
                score += 1;
            }
            if (s[n - 1 - i] == 'a' || s[n - 1 - i] == 'e' || s[n - 1 - i] == 'i' || s[n - 1 - i] == 'o' || s[n - 1 - i] == 'u') {
                score += 1;
            }
        }
        return score;
    }
};
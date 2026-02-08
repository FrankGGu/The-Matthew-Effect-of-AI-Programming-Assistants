class Solution {
public:
    bool detectCapitalUse(string word) {
        int n = word.length();
        if (n == 0) return false;
        bool firstCapital = isupper(word[0]);
        bool allCaps = isupper(word[0]);
        bool allLower = islower(word[0]);

        for (int i = 1; i < n; i++) {
            if (isupper(word[i])) {
                allLower = false;
                allCaps = allCaps && true;
            } else {
                allCaps = false;
            }
        }

        return allCaps || allLower || (firstCapital && allLower);
    }
};
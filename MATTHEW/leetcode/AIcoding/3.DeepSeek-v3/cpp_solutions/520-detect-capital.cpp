class Solution {
public:
    bool detectCapitalUse(string word) {
        int n = word.size();
        bool allUpper = true;
        bool allLower = true;
        bool firstUpper = true;

        for (int i = 0; i < n; ++i) {
            if (islower(word[i])) {
                allUpper = false;
            } else {
                allLower = false;
            }

            if (i == 0) {
                if (!isupper(word[i])) {
                    firstUpper = false;
                }
            } else {
                if (isupper(word[i])) {
                    firstUpper = false;
                }
            }
        }

        return allUpper || allLower || firstUpper;
    }
};
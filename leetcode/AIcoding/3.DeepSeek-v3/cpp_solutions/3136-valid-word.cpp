class Solution {
public:
    bool isValid(string word) {
        if (word.size() < 3) return false;
        bool hasVowel = false;
        bool hasConsonant = false;
        for (char c : word) {
            if (!isalnum(c)) return false;
            if (tolower(c) == 'a' || tolower(c) == 'e' || tolower(c) == 'i' || tolower(c) == 'o' || tolower(c) == 'u') {
                hasVowel = true;
            } else if (isalpha(c)) {
                hasConsonant = true;
            }
        }
        return hasVowel && hasConsonant;
    }
};
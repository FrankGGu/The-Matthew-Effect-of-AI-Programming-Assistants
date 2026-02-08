class Solution {
public:
    bool isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    int vowelStrings(std::vector<std::string>& words, int left, int right) {
        int count = 0;
        for (int i = left; i <= right; ++i) {
            if (isVowel(words[i][0]) && isVowel(words[i].back())) {
                count++;
            }
        }
        return count;
    }
};
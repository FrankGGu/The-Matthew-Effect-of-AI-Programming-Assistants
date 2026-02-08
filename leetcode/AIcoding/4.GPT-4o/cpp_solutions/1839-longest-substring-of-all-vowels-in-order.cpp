class Solution {
public:
    int longestBeautifulSubstring(string word) {
        int maxLength = 0, currentLength = 0, uniqueVowels = 0;
        vector<int> vowelCount(5, 0);

        for (int i = 0; i < word.size(); ++i) {
            if (i == 0 || word[i] != word[i - 1]) {
                if (word[i] == 'a') {
                    if (uniqueVowels == 0) uniqueVowels++;
                    if (uniqueVowels == 1) currentLength++;
                } else if (word[i] == 'e' && uniqueVowels == 1) {
                    uniqueVowels++;
                    currentLength++;
                } else if (word[i] == 'i' && uniqueVowels == 2) {
                    uniqueVowels++;
                    currentLength++;
                } else if (word[i] == 'o' && uniqueVowels == 3) {
                    uniqueVowels++;
                    currentLength++;
                } else if (word[i] == 'u' && uniqueVowels == 4) {
                    uniqueVowels++;
                    currentLength++;
                } else {
                    currentLength = uniqueVowels = (word[i] == 'a') ? 1 : 0;
                }
            } else {
                currentLength++;
            }

            if (uniqueVowels == 5) {
                maxLength = max(maxLength, currentLength);
            }
        }

        return maxLength;
    }
};
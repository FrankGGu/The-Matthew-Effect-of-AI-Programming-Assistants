class Solution {
public:
    int isPrefixOfWord(string sentence, string searchWord) {
        int wordCount = 0;
        int n = sentence.size();
        int m = searchWord.size();

        for (int i = 0; i <= n - m; ++i) {
            if (i == 0 || sentence[i-1] == ' ') {
                wordCount++;
                bool match = true;
                for (int j = 0; j < m; ++j) {
                    if (sentence[i + j] != searchWord[j]) {
                        match = false;
                        break;
                    }
                }
                if (match) {
                    return wordCount;
                }
            }
        }

        return -1;
    }
};
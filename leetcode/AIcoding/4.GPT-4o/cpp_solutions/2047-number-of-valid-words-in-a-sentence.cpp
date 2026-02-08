class Solution {
public:
    int countValidWords(string sentence) {
        istringstream iss(sentence);
        string word;
        int count = 0;

        while (iss >> word) {
            int n = word.size();
            bool hasHyphen = false, hasDigit = false, hasPunctuation = false;
            if (n == 0) continue;
            if (isalpha(word[0]) && (isalpha(word[n - 1]) || word[n - 1] == ',' || word[n - 1] == '.' || word[n - 1] == '!')) {
                for (int i = 0; i < n; ++i) {
                    if (isdigit(word[i])) {
                        hasDigit = true;
                        break;
                    }
                    if (word[i] == '-') {
                        if (hasHyphen || (i == 0 || i == n - 1 || !isalpha(word[i - 1]) || !isalpha(word[i + 1]))) {
                            hasHyphen = true;
                            break;
                        }
                        hasHyphen = true;
                    }
                    if (word[i] == ',' || word[i] == '.' || word[i] == '!') {
                        hasPunctuation = true;
                        if (i != n - 1) {
                            hasPunctuation = true;
                        }
                    }
                }
                if (!hasDigit && !hasHyphen) {
                    count++;
                }
            }
        }

        return count;
    }
};
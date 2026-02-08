class Solution {
public:
    int countValidWords(string sentence) {
        int res = 0;
        stringstream ss(sentence);
        string word;
        while (ss >> word) {
            bool valid = true;
            int hyphen = 0;
            int n = word.size();
            for (int i = 0; i < n; ++i) {
                char c = word[i];
                if (isdigit(c)) {
                    valid = false;
                    break;
                }
                if (c == '-') {
                    if (hyphen++ > 0 || i == 0 || i == n - 1 || !isalpha(word[i - 1]) {
                        valid = false;
                        break;
                    }
                    if (i + 1 < n && !isalpha(word[i + 1])) {
                        valid = false;
                        break;
                    }
                }
                if ((c == '!' || c == '.' || c == ',') && i != n - 1) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                ++res;
            }
        }
        return res;
    }
};
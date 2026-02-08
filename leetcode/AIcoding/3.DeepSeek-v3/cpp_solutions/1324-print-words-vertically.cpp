class Solution {
public:
    vector<string> printVertically(string s) {
        vector<string> words;
        stringstream ss(s);
        string word;
        int max_len = 0;
        while (ss >> word) {
            words.push_back(word);
            max_len = max(max_len, (int)word.size());
        }

        vector<string> result(max_len);
        for (int i = 0; i < max_len; ++i) {
            for (int j = 0; j < words.size(); ++j) {
                if (i < words[j].size()) {
                    result[i] += words[j][i];
                } else {
                    result[i] += ' ';
                }
            }
        }

        for (int i = 0; i < result.size(); ++i) {
            int j = result[i].size() - 1;
            while (j >= 0 && result[i][j] == ' ') {
                j--;
            }
            result[i] = result[i].substr(0, j + 1);
        }

        return result;
    }
};
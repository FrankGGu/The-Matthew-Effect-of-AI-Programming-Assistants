#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> printVertically(string s) {
        vector<string> words;
        string current_word = "";
        for (char c : s) {
            if (c == ' ') {
                words.push_back(current_word);
                current_word = "";
            } else {
                current_word += c;
            }
        }
        words.push_back(current_word);

        int max_len = 0;
        for (const string& word : words) {
            max_len = max(max_len, (int)word.length());
        }

        vector<string> result(max_len, "");
        for (int i = 0; i < max_len; ++i) {
            for (const string& word : words) {
                if (i < word.length()) {
                    result[i] += word[i];
                } else {
                    result[i] += ' ';
                }
            }
            while (result[i].back() == ' ') {
                result[i].pop_back();
            }
        }

        return result;
    }
};
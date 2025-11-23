#include <vector>
#include <string>
#include <sstream>
#include <algorithm>

class Solution {
public:
    vector<string> printVertically(string s) {
        vector<string> words;
        stringstream ss(s);
        string word;
        while (ss >> word) {
            words.push_back(word);
        }

        int maxLength = 0;
        for (const auto& w : words) {
            maxLength = max(maxLength, (int)w.size());
        }

        vector<string> result;
        for (int i = 0; i < maxLength; ++i) {
            string verticalWord;
            for (const auto& w : words) {
                verticalWord += (i < w.size() ? w[i] : ' ');
            }
            while (!verticalWord.empty() && verticalWord.back() == ' ') {
                verticalWord.pop_back();
            }
            result.push_back(verticalWord);
        }

        return result;
    }
};
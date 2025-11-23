#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string arrangeWords(string text) {
        text[0] = tolower(text[0]);
        vector<pair<int, string>> words;
        string word;
        int start = 0;
        for (int i = 0; i < text.length(); ++i) {
            if (text[i] == ' ') {
                word = text.substr(start, i - start);
                words.push_back({word.length(), word});
                start = i + 1;
            }
        }
        word = text.substr(start);
        words.push_back({word.length(), word});

        sort(words.begin(), words.end());

        string result = "";
        for (int i = 0; i < words.size(); ++i) {
            result += words[i].second;
            if (i < words.size() - 1) {
                result += " ";
            }
        }

        result[0] = toupper(result[0]);
        return result;
    }
};
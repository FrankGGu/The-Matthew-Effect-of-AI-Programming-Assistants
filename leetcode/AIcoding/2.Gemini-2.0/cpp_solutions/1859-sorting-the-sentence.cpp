#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string sortSentence(string s) {
        vector<pair<int, string>> words;
        string word;
        for (char c : s) {
            if (c == ' ') {
                int pos = word.back() - '0';
                word.pop_back();
                words.push_back({pos, word});
                word = "";
            } else {
                word += c;
            }
        }
        int pos = word.back() - '0';
        word.pop_back();
        words.push_back({pos, word});

        sort(words.begin(), words.end());

        string result = "";
        for (int i = 0; i < words.size(); ++i) {
            result += words[i].second;
            if (i < words.size() - 1) {
                result += " ";
            }
        }

        return result;
    }
};
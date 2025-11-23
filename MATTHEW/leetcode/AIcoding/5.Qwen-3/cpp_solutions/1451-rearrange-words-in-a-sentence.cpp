#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <sstream>

using namespace std;

class Solution {
public:
    string arrangeWords(string sentence) {
        istringstream iss(sentence);
        vector<string> words;
        string word;
        while (iss >> word) {
            words.push_back(word);
        }
        if (words.empty()) return "";
        transform(words[0].begin(), words[0].end(), words[0].begin(), ::tolower);
        sort(words.begin(), words.end(), [](const string& a, const string& b) {
            return a.length() < b.length() || (a.length() == b.length() && a < b);
        });
        string result;
        for (size_t i = 0; i < words.size(); ++i) {
            if (i > 0) result += " ";
            result += words[i];
        }
        result[0] = toupper(result[0]);
        return result;
    }
};
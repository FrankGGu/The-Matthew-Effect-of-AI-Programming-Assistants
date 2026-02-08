#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <algorithm>

using namespace std;

class Solution {
public:
    string sortSentence(string s) {
        vector<string> words;
        stringstream ss(s);
        string word;
        while (ss >> word) {
            words.push_back(word);
        }

        vector<string> result(words.size());
        for (const auto& w : words) {
            int pos = w.back() - '0';
            result[pos - 1] = w.substr(0, w.size() - 1);
        }

        string res;
        for (const auto& w : result) {
            res += w + " ";
        }
        if (!res.empty()) {
            res.pop_back();
        }
        return res;
    }
};
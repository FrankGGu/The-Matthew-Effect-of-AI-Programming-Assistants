#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string longestWord(vector<string>& words) {
        sort(words.begin(), words.end());
        string result;
        vector<string> prefixes;
        for (const string& word : words) {
            if (word.length() == 1 || find(prefixes.begin(), prefixes.end(), word.substr(0, word.length() - 1)) != prefixes.end()) {
                prefixes.push_back(word);
                if (word.length() > result.length()) {
                    result = word;
                }
            }
        }
        return result;
    }
};
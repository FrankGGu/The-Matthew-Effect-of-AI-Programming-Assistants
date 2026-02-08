#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumLengthEncoding(vector<string>& words) {
        unordered_set<string> wordSet(words.begin(), words.end());
        for (const string& word : words) {
            for (int i = 1; i < word.size(); ++i) {
                wordSet.erase(word.substr(i));
            }
        }
        int result = 0;
        for (const string& word : wordSet) {
            result += word.size() + 1;
        }
        return result;
    }
};
#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumEncoding(vector<string>& words) {
        unordered_set<string> wordSet(words.begin(), words.end());
        for (auto word : words) {
            for (int i = 1; i < word.length(); ++i) {
                wordSet.erase(word.substr(i));
            }
        }
        int result = 0;
        for (const auto& word : wordSet) {
            result += word.length() + 1;
        }
        return result;
    }
};
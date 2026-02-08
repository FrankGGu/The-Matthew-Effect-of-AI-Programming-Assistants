#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string findLongestWord(string s, vector<string>& d) {
        sort(d.begin(), d.end(), [](const string& a, const string& b) {
            if (a.size() != b.size()) return a.size() < b.size();
            return a < b;
        });

        for (const auto& word : d) {
            int i = 0, j = 0;
            while (i < s.size() && j < word.size()) {
                if (s[i] == word[j]) j++;
                i++;
            }
            if (j == word.size()) return word;
        }
        return "";
    }
};
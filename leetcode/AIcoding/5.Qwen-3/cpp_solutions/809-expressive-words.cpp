#include <iostream>
#include <vector>
#include <string>
#include <map>

using namespace std;

class Solution {
public:
    vector<string> expressiveWords(vector<string>& words, string s) {
        vector<string> result;
        for (const string& word : words) {
            if (isExpressive(word, s)) {
                result.push_back(word);
            }
        }
        return result;
    }

private:
    bool isExpressive(const string& word, const string& s) {
        int i = 0, j = 0;
        while (i < word.length() && j < s.length()) {
            if (word[i] != s[j]) return false;
            char c = word[i];
            int count1 = 0, count2 = 0;
            while (i < word.length() && word[i] == c) { i++; count1++; }
            while (j < s.length() && s[j] == c) { j++; count2++; }
            if (count1 > count2 || (count2 < 3 && count1 < count2)) return false;
        }
        return i == word.length() && j == s.length();
    }
};
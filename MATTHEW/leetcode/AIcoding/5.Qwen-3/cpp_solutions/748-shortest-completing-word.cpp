#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string shortestCompletingWord(string s, vector<string>& words) {
        unordered_map<char, int> count;
        for (char c : s) {
            if (isalpha(c)) {
                count[tolower(c)]++;
            }
        }

        string result;
        int minLen = INT_MAX;

        for (const string& word : words) {
            unordered_map<char, int> temp;
            bool valid = true;
            for (char c : word) {
                if (isalpha(c)) {
                    temp[tolower(c)]++;
                }
            }

            for (const auto& p : count) {
                if (temp[p.first] < p.second) {
                    valid = false;
                    break;
                }
            }

            if (valid && word.length() < minLen) {
                minLen = word.length();
                result = word;
            }
        }

        return result;
    }
};
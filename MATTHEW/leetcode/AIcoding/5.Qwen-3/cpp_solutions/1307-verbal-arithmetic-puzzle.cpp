#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool isSolvable(vector<string>& words, string result) {
        if (result.length() > 1 && words.empty()) return false;
        for (const auto& word : words) {
            if (word.length() > result.length()) return false;
        }

        unordered_map<char, int> charToDigit;
        unordered_set<char> usedDigits;
        vector<char> uniqueChars;
        for (const auto& word : words) {
            for (char c : word) {
                if (find(uniqueChars.begin(), uniqueChars.end(), c) == uniqueChars.end()) {
                    uniqueChars.push_back(c);
                }
            }
        }
        for (char c : result) {
            if (find(uniqueChars.begin(), uniqueChars.end(), c) == uniqueChars.end()) {
                uniqueChars.push_back(c);
            }
        }

        vector<char> leadingChars;
        for (const auto& word : words) {
            if (word.length() > 0) leadingChars.push_back(word[0]);
        }
        if (result.length() > 0) leadingChars.push_back(result[0]);

        vector<int> digits(10);
        for (int i = 0; i < 10; ++i) digits[i] = i;

        return backtrack(words, result, 0, 0, 0, charToDigit, usedDigits, uniqueChars, leadingChars, digits);
    }

private:
    bool backtrack(vector<string>& words, string& result, int index, int carry, int col, unordered_map<char, int>& charToDigit, unordered_set<char>& usedDigits, vector<char>& uniqueChars, vector<char>& leadingChars, vector<int>& digits) {
        if (index == uniqueChars.size()) {
            return checkSolution(words, result, charToDigit);
        }

        char c = uniqueChars[index];
        bool isLeading = find(leadingChars.begin(), leadingChars.end(), c) != leadingChars.end();

        for (int d = 0; d < 10; ++d) {
            if (usedDigits.find(c) != usedDigits.end()) continue;
            if (d == 0 && isLeading) continue;

            int sum = 0;
            for (const auto& word : words) {
                if (col < word.length()) {
                    sum += charToDigit[word[word.length() - 1 - col]];
                }
            }
            sum += carry;
            int digit = sum % 10;
            int newCarry = sum / 10;

            if (col < result.length()) {
                int resDigit = charToDigit[result[result.length() - 1 - col]];
                if (digit != resDigit) continue;
            }

            charToDigit[c] = d;
            usedDigits.insert(c);

            if (backtrack(words, result, index + 1, newCarry, col, charToDigit, usedDigits, uniqueChars, leadingChars, digits)) {
                return true;
            }

            usedDigits.erase(c);
            charToDigit.erase(c);
        }

        return false;
    }

    bool checkSolution(vector<string>& words, string& result, unordered_map<char, int>& charToDigit) {
        long long total = 0;
        for (const auto& word : words) {
            long long val = 0;
            for (int i = word.length() - 1; i >= 0; --i) {
                val = val * 10 + charToDigit[word[i]];
            }
            total += val;
        }

        long long resVal = 0;
        for (int i = result.length() - 1; i >= 0; --i) {
            resVal = resVal * 10 + charToDigit[result[i]];
        }

        return total == resVal;
    }
};
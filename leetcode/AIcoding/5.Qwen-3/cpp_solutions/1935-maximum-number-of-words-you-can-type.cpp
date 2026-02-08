#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int canBeTypedWords(vector<string>& text, vector<char>& brokenLetters) {
        unordered_set<char> broken(brokenLetters.begin(), brokenLetters.end());
        int count = 0;
        string word;
        for (char c : text) {
            if (c == ' ') {
                bool valid = true;
                for (char ch : word) {
                    if (broken.find(ch) != broken.end()) {
                        valid = false;
                        break;
                    }
                }
                if (valid) count++;
                word.clear();
            } else {
                word += c;
            }
        }
        bool valid = true;
        for (char ch : word) {
            if (broken.find(ch) != broken.end()) {
                valid = false;
                break;
            }
        }
        if (valid) count++;
        return count;
    }
};
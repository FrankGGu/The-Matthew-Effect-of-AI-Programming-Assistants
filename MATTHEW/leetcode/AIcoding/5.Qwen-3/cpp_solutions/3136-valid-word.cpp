#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool isValidWord(string word, vector<string> abil) {
        unordered_set<char> allowed;
        for (char c : abil[0]) {
            allowed.insert(c);
        }
        for (char c : word) {
            if (allowed.find(c) == allowed.end()) {
                return false;
            }
        }
        return true;
    }
};
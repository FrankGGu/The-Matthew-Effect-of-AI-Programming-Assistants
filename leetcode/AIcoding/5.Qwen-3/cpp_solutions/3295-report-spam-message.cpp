#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool reportSpamMessage(vector<string>& message, vector<string>& bannedWords) {
        unordered_set<string> banned(bannedWords.begin(), bannedWords.end());
        int count = 0;
        for (const string& word : message) {
            if (banned.find(word) != banned.end()) {
                count++;
                if (count >= 2) {
                    return true;
                }
            }
        }
        return false;
    }
};
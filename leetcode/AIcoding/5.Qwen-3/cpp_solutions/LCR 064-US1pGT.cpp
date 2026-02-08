#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    void buildDict(vector<string> dictionary) {
        for (const string& word : dictionary) {
            int len = word.length();
            dict[len].push_back(word);
        }
    }

    bool search(string searchWord) {
        int len = searchWord.length();
        if (dict.find(len) == dict.end()) {
            return false;
        }
        for (const string& word : dict[len]) {
            int diff = 0;
            for (int i = 0; i < len; ++i) {
                if (word[i] != searchWord[i]) {
                    ++diff;
                    if (diff > 1) {
                        break;
                    }
                }
            }
            if (diff == 1) {
                return true;
            }
        }
        return false;
    }

private:
    unordered_map<int, vector<string>> dict;
};
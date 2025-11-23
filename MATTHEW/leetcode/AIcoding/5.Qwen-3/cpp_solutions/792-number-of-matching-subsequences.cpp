#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int numMatchingSubseq(string s, vector<string>& words) {
        unordered_map<char, vector<string>> groups;
        for (string word : words) {
            groups[word[0]].push_back(word);
        }

        for (char c : s) {
            vector<string> pending = groups[c];
            groups[c].clear();
            for (string word : pending) {
                if (word.size() == 1) {
                    ++count;
                } else {
                    groups[word[1]].push_back(word.substr(1));
                }
            }
        }

        return count;
    }
};
#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> countMentionsPerUser(vector<string> tweets) {
        unordered_map<string, int> mentionCount;
        for (const string& tweet : tweets) {
            for (size_t i = 0; i < tweet.length(); ++i) {
                if (tweet[i] == '@') {
                    size_t j = i + 1;
                    while (j < tweet.length() && (isalnum(tweet[j]) || tweet[j] == '_')) {
                        ++j;
                    }
                    if (i + 1 < j) {
                        string username = tweet.substr(i + 1, j - (i + 1));
                        mentionCount[username]++;
                    }
                }
            }
        }
        vector<int> result;
        for (const auto& pair : mentionCount) {
            result.push_back(pair.second);
        }
        return result;
    }
};
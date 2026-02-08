#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countPrefixSuffixPairs(int n, vector<string>& words) {
        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (words[j].size() >= words[i].size() && 
                    words[j].substr(0, words[i].size()) == words[i] && 
                    words[j].substr(words[j].size() - words[i].size()) == words[i]) {
                    ++count;
                }
            }
        }
        return count;
    }
};
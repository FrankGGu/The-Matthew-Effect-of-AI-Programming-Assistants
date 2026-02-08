#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <algorithm>

class Solution {
public:
    bool closeStrings(std::string word1, std::string word2) {
        if (word1.length() != word2.length()) {
            return false;
        }

        std::map<char, int> count1, count2;
        for (char c : word1) {
            count1[c]++;
        }
        for (char c : word2) {
            count2[c]++;
        }

        if (count1.size() != count2.size()) {
            return false;
        }

        std::vector<int> freq1, freq2;
        for (auto& pair : count1) {
            freq1.push_back(pair.second);
        }
        for (auto& pair : count2) {
            freq2.push_back(pair.second);
        }

        std::sort(freq1.begin(), freq1.end());
        std::sort(freq2.begin(), freq2.end());

        return freq1 == freq2;
    }
};
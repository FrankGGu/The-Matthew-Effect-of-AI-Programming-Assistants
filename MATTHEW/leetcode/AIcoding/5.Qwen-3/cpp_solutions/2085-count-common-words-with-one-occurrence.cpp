#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    int countWords(vector<string>& words1, vector<string>& words2) {
        std::unordered_map<std::string, int> count1;
        std::unordered_map<std::string, int> count2;

        for (const auto& word : words1) {
            count1[word]++;
        }

        for (const auto& word : words2) {
            count2[word]++;
        }

        int result = 0;
        for (const auto& pair : count1) {
            if (pair.second == 1 && count2.find(pair.first) != count2.end() && count2[pair.first] == 1) {
                result++;
            }
        }

        return result;
    }
};
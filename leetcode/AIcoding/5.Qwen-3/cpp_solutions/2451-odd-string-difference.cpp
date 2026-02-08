#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string oddString(vector<string>& words) {
        unordered_map<string, vector<string>> map;
        for (const auto& word : words) {
            string diff;
            for (int i = 1; i < word.length(); ++i) {
                diff += to_string(word[i] - word[i-1]) + ",";
            }
            map[diff].push_back(word);
        }

        for (const auto& pair : map) {
            if (pair.second.size() == 1) {
                return pair.second[0];
            }
        }

        return "";
    }
};
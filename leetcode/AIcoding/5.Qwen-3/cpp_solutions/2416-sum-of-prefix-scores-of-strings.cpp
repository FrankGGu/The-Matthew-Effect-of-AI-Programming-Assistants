#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> prefixScores(const vector<string>& words) {
        unordered_map<string, int> prefixCount;
        for (const string& word : words) {
            string prefix;
            for (char c : word) {
                prefix += c;
                prefixCount[prefix]++;
            }
        }

        vector<int> result;
        for (const string& word : words) {
            string prefix;
            int score = 0;
            for (char c : word) {
                prefix += c;
                score += prefixCount[prefix];
            }
            result.push_back(score);
        }

        return result;
    }
};
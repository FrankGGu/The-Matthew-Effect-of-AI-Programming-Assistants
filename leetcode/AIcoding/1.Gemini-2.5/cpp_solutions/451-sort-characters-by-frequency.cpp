#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string frequencySort(string s) {
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        vector<pair<char, int>> charFreq;
        for (auto const& [key, val] : freq) {
            charFreq.push_back({key, val});
        }

        sort(charFreq.begin(), charFreq.end(), [](const pair<char, int>& a, const pair<char, int>& b) {
            return a.second > b.second;
        });

        string result = "";
        for (auto const& [c, f] : charFreq) {
            result += string(f, c);
        }

        return result;
    }
};
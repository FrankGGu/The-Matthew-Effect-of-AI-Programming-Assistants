#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string reverseDegree(string s) {
        unordered_map<char, int> count;
        for (char c : s) {
            count[c]++;
        }

        vector<pair<int, char>> freq;
        for (auto& p : count) {
            freq.push_back({p.second, p.first});
        }

        sort(freq.begin(), freq.end());

        string result;
        for (auto& p : freq) {
            for (int i = 0; i < p.first; ++i) {
                result += p.second;
            }
        }

        return result;
    }
};
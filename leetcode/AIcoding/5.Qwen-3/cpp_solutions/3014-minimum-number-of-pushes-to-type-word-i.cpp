#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minimumPushes(string word) {
        unordered_map<char, int> freq;
        for (char c : word) {
            freq[c]++;
        }

        vector<int> counts;
        for (auto& pair : freq) {
            counts.push_back(pair.second);
        }

        sort(counts.begin(), counts.end(), greater<int>());

        int pushes = 0;
        for (int i = 0; i < counts.size(); ++i) {
            pushes += counts[i] * ((i / 8) + 1);
        }

        return pushes;
    }
};
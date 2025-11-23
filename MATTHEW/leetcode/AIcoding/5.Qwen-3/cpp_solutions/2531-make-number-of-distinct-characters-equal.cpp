#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool canMakeEqual(vector<string>& words) {
        unordered_map<char, int> freq;
        for (const string& word : words) {
            for (char c : word) {
                freq[c]++;
            }
        }

        int totalChars = 0;
        for (const auto& pair : freq) {
            totalChars += pair.second;
        }

        int distinctChars = freq.size();
        return totalChars % distinctChars == 0;
    }
};
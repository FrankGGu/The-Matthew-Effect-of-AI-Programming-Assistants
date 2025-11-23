#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countStrings(vector<string>& words) {
        unordered_map<string, int> freq;
        for (const string& word : words) {
            string sorted = word;
            sort(sorted.begin(), sorted.end());
            freq[sorted]++;
        }

        int count = 0;
        for (const auto& [key, val] : freq) {
            if (val >= 2) {
                count += val * (val - 1) / 2;
            }
        }
        return count;
    }
};
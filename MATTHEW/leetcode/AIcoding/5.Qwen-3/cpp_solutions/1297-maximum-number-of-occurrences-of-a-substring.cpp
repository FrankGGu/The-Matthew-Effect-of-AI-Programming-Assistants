#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxNumberOfOccurrences(string text, string pattern) {
        int count = 0;
        int n = text.length();
        int m = pattern.length();
        if (m == 0 || n < m) return 0;

        unordered_map<string, int> freq;
        for (int i = 0; i <= n - m; ++i) {
            string sub = text.substr(i, m);
            freq[sub]++;
        }

        int maxCount = 0;
        for (auto& pair : freq) {
            if (pair.second > maxCount) {
                maxCount = pair.second;
            }
        }

        return maxCount;
    }
};
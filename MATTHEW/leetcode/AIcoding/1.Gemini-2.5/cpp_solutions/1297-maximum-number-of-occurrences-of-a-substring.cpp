#include <iostream>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxFreq(string s, int maxLetters, int minSize, int maxSize) {
        int n = s.length();
        unordered_map<string, int> counts;
        int maxCount = 0;

        for (int i = 0; i <= n - minSize; ++i) {
            string sub = s.substr(i, minSize);
            unordered_map<char, int> charCounts;
            int distinctChars = 0;
            for (char c : sub) {
                if (charCounts.find(c) == charCounts.end()) {
                    distinctChars++;
                }
                charCounts[c]++;
            }

            if (distinctChars <= maxLetters) {
                counts[sub]++;
                maxCount = max(maxCount, counts[sub]);
            }
        }

        return maxCount;
    }
};
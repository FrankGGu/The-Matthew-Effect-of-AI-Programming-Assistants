#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxEqualRowsAfterFlips(vector<vector<int>>& matrix) {
        unordered_map<string, int> patternCount;
        for (const auto& row : matrix) {
            string pattern;
            for (int j = 0; j < row.size(); ++j) {
                if (row[j] == 1) {
                    pattern += '1';
                } else {
                    pattern += '0';
                }
            }
            patternCount[pattern]++;
        }

        int maxCount = 0;
        for (const auto& [pattern, count] : patternCount) {
            string flipPattern;
            for (char c : pattern) {
                flipPattern += (c == '0' ? '1' : '0');
            }
            maxCount = max(maxCount, count + patternCount[flipPattern]);
        }

        return maxCount;
    }
};
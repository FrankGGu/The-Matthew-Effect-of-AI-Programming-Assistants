#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int maxScore(string s) {
        int totalOnes = 0;
        for (char c : s) {
            if (c == '1') {
                totalOnes++;
            }
        }

        int leftOnes = 0;
        int maxScore = 0;

        for (int i = 0; i < s.length() - 1; ++i) {
            if (s[i] == '1') {
                leftOnes++;
            }
            int rightOnes = totalOnes - leftOnes;
            int currentScore = leftOnes + rightOnes;
            maxScore = max(maxScore, currentScore);
        }

        return maxScore;
    }
};
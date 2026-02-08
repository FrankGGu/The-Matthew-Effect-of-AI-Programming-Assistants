#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int bagOfTokens(vector<int>& tokens, int power) {
        sort(tokens.begin(), tokens.end());
        int left = 0;
        int right = tokens.size() - 1;
        int maxScore = 0;
        int currentScore = 0;

        while (left <= right) {
            if (tokens[left] <= power) {
                power -= tokens[left];
                left++;
                currentScore++;
                maxScore = max(maxScore, currentScore);
            } else if (currentScore > 0) {
                power += tokens[right];
                right--;
                currentScore--;
            } else {
                break;
            }
        }

        return maxScore;
    }
};
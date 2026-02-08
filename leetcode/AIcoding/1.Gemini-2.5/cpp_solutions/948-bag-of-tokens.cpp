#include <vector>
#include <algorithm>

class Solution {
public:
    int bagOfTokensScore(std::vector<int>& tokens, int power) {
        std::sort(tokens.begin(), tokens.end());

        int score = 0;
        int max_score = 0;
        int left = 0;
        int right = tokens.size() - 1;

        while (left <= right) {
            if (power >= tokens[left]) {
                power -= tokens[left];
                score++;
                left++;
                max_score = std::max(max_score, score);
            } else if (score > 0 && left < right) {
                power += tokens[right];
                score--;
                right--;
            } else {
                break;
            }
        }

        return max_score;
    }
};
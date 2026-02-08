#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int bagOfTokensScore(vector<int>& tokens, int power) {
        sort(tokens.begin(), tokens.end());
        int score = 0;
        int left = 0;
        int right = tokens.size() - 1;

        while (left <= right) {
            if (power >= tokens[left]) {
                power -= tokens[left];
                score++;
                left++;
            } else if (score > 0 && left < right) {
                power += tokens[right];
                score--;
                right--;
            } else {
                break;
            }
        }

        return score;
    }
};
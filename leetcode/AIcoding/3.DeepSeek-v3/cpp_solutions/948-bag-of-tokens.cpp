#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int bagOfTokensScore(vector<int>& tokens, int P) {
        sort(tokens.begin(), tokens.end());
        int left = 0, right = tokens.size() - 1;
        int score = 0, maxScore = 0;
        while (left <= right) {
            if (P >= tokens[left]) {
                P -= tokens[left];
                left++;
                score++;
                maxScore = max(maxScore, score);
            } else if (score > 0) {
                P += tokens[right];
                right--;
                score--;
            } else {
                break;
            }
        }
        return maxScore;
    }
};
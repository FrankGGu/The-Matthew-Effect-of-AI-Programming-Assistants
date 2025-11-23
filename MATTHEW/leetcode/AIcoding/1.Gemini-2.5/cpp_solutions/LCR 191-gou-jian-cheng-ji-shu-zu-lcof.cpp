#include <vector>
#include <numeric>

class Solution {
public:
    int countScores(std::vector<int>& scores) {
        std::vector<int> valid_scores;
        for (int score : scores) {
            if (score >= 60) {
                valid_scores.push_back(score);
            }
        }

        if (valid_scores.empty()) {
            return 0;
        }

        double sum = 0;
        for (int score : valid_scores) {
            sum += score;
        }
        double average = sum / valid_scores.size();

        int count = 0;
        for (int score : valid_scores) {
            if (score >= average) {
                count++;
            }
        }

        return count;
    }
};
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> sortTheStudents(std::vector<std::vector<int>>& score, int k) {
        std::sort(score.begin(), score.end(), [&](const std::vector<int>& a, const std::vector<int>& b) {
            return a[k] > b[k];
        });
        return score;
    }
};
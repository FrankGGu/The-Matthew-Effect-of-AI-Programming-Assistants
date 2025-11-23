#include <vector>
#include <string>
#include <numeric> // for std::accumulate

class Solution {
public:
    int calPoints(std::vector<std::string>& ops) {
        std::vector<int> scores;
        for (const std::string& op : ops) {
            if (op == "+") {
                int score1 = scores.back();
                int score2 = scores[scores.size() - 2];
                scores.push_back(score1 + score2);
            } else if (op == "D") {
                scores.push_back(scores.back() * 2);
            } else if (op == "C") {
                scores.pop_back();
            } else {
                scores.push_back(std::stoi(op));
            }
        }

        int sum = 0;
        for (int score : scores) {
            sum += score;
        }
        return sum;
        // Or using std::accumulate
        // return std::accumulate(scores.begin(), scores.end(), 0);
    }
};
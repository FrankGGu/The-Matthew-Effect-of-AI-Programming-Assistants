#include <vector>
#include <string>
#include <unordered_set>
#include <sstream>
#include <algorithm>
#include <utility> // For std::pair

class Solution {
public:
    std::vector<int> topStudents(std::vector<std::string>& positive_feedback,
                                 std::vector<std::string>& negative_feedback,
                                 std::vector<std::string>& report,
                                 std::vector<int>& student_id,
                                 int k) {

        std::unordered_set<std::string> positive_words(positive_feedback.begin(), positive_feedback.end());
        std::unordered_set<std::string> negative_words(negative_feedback.begin(), negative_feedback.end());

        std::vector<std::pair<int, int>> student_scores_and_ids;

        for (int i = 0; i < report.size(); ++i) {
            int current_score = 0;
            std::stringstream ss(report[i]);
            std::string word;

            while (ss >> word) {
                if (positive_words.count(word)) {
                    current_score += 3;
                } else if (negative_words.count(word)) {
                    current_score -= 1;
                }
            }
            student_scores_and_ids.push_back({current_score, student_id[i]});
        }

        std::sort(student_scores_and_ids.begin(), student_scores_and_ids.end(), [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
            if (a.first != b.first) {
                return a.first > b.first;
            }
            return a.second < b.second;
        });

        std::vector<int> result;
        for (int i = 0; i < k; ++i) {
            result.push_back(student_scores_and_ids[i].second);
        }

        return result;
    }
};
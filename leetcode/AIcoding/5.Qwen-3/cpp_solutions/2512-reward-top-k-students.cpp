#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> topStudents(vector<string>& positive_feedback, vector<string>& negative_feedback, vector<string>& report, vector<int>& student_id, int k) {
        unordered_map<string, int> feedback_score;
        for (const auto& word : positive_feedback) {
            feedback_score[word] = 1;
        }
        for (const auto& word : negative_feedback) {
            feedback_score[word] = -1;
        }

        vector<pair<int, string>> score_id;
        for (int i = 0; i < report.size(); ++i) {
            int score = 0;
            string& r = report[i];
            string word;
            for (char c : r) {
                if (c == ' ') {
                    if (feedback_score.find(word) != feedback_score.end()) {
                        score += feedback_score[word];
                    }
                    word.clear();
                } else {
                    word += c;
                }
            }
            if (!word.empty() && feedback_score.find(word) != feedback_score.end()) {
                score += feedback_score[word];
            }
            score_id.emplace_back(-score, to_string(student_id[i]));
        }

        sort(score_id.begin(), score_id.end());

        vector<string> result;
        for (int i = 0; i < min(k, (int)score_id.size()); ++i) {
            result.push_back(score_id[i].second);
        }

        return result;
    }
};
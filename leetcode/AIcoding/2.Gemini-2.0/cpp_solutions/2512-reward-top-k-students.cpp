#include <vector>
#include <string>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> rewardTopK(vector<string>& positive_feedback, vector<string>& negative_feedback, vector<string>& report, vector<int>& student_id, int k) {
        unordered_map<string, int> feedback_score;
        for (const string& word : positive_feedback) {
            feedback_score[word] = 3;
        }
        for (const string& word : negative_feedback) {
            feedback_score[word] = -1;
        }

        priority_queue<pair<int, int>> pq; 
        for (int i = 0; i < report.size(); ++i) {
            int score = 0;
            string word;
            for (int j = 0; j < report[i].size(); ++j) {
                if (report[i][j] == ' ') {
                    if (feedback_score.count(word)) {
                        score += feedback_score[word];
                    }
                    word = "";
                } else {
                    word += report[i][j];
                }
            }
            if (feedback_score.count(word)) {
                score += feedback_score[word];
            }
            pq.push({score, -student_id[i]});
        }

        vector<int> result;
        for (int i = 0; i < k && !pq.empty(); ++i) {
            result.push_back(-pq.top().second);
            pq.pop();
        }

        return result;
    }
};
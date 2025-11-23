class Solution {
public:
    vector<int> topStudents(vector<string>& positive_feedback, vector<string>& negative_feedback, vector<string>& report, vector<int>& student_id, int k) {
        unordered_set<string> pos(positive_feedback.begin(), positive_feedback.end());
        unordered_set<string> neg(negative_feedback.begin(), negative_feedback.end());

        vector<pair<int, int>> scores; // score, id

        for (int i = 0; i < report.size(); ++i) {
            stringstream ss(report[i]);
            string word;
            int score = 0;
            while (ss >> word) {
                if (pos.count(word)) {
                    score += 3;
                } else if (neg.count(word)) {
                    score -= 1;
                }
            }
            scores.emplace_back(-score, student_id[i]);
        }

        sort(scores.begin(), scores.end());

        vector<int> result;
        for (int i = 0; i < k; ++i) {
            result.push_back(scores[i].second);
        }

        return result;
    }
};
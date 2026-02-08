class Solution {
public:
    int maxCompatibilitySum(vector<vector<int>>& students, vector<vector<int>>& mentors) {
        int n = students.size();
        vector<int> perm(n);
        iota(perm.begin(), perm.end(), 0);
        int maxScore = 0;

        do {
            int currentScore = 0;
            for (int i = 0; i < n; ++i) {
                currentScore += compatibilityScore(students[i], mentors[perm[i]]);
            }
            maxScore = max(maxScore, currentScore);
        } while (next_permutation(perm.begin(), perm.end()));

        return maxScore;
    }

private:
    int compatibilityScore(const vector<int>& student, const vector<int>& mentor) {
        int score = 0;
        for (int i = 0; i < student.size(); ++i) {
            score += (student[i] == mentor[i]);
        }
        return score;
    }
};
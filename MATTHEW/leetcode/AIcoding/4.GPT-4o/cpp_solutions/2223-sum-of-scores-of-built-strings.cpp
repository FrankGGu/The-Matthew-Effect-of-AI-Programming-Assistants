class Solution {
public:
    int sumOfScores(vector<string>& words) {
        int n = words.size();
        vector<int> scores(n, 0);
        vector<int> suffixCount(26, 0);
        int totalScore = 0;

        for (int i = 0; i < n; ++i) {
            int length = words[i].length();
            for (int j = 0; j < length; ++j) {
                suffixCount[words[i][j] - 'a']++;
            }
            for (int j = 0; j < length; ++j) {
                scores[i] += suffixCount[words[i][j] - 'a'];
            }
            totalScore += scores[i];
            for (int j = 0; j < length; ++j) {
                suffixCount[words[i][j] - 'a']--;
            }
        }

        return totalScore;
    }
};
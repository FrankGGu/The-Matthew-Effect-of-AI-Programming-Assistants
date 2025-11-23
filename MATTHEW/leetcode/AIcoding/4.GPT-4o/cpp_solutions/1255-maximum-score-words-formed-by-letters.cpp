class Solution {
public:
    int maxScoreWords(vector<string>& words, vector<int>& score) {
        int n = words.size(), maxScore = 0;
        vector<int> count(26, 0);

        function<void(int, int)> backtrack = [&](int idx, int currentScore) {
            if (idx == n) {
                maxScore = max(maxScore, currentScore);
                return;
            }

            // Skip the current word
            backtrack(idx + 1, currentScore);

            // Try to include the current word
            vector<int> tempCount = count;
            int wordScore = 0;
            bool valid = true;

            for (char c : words[idx]) {
                tempCount[c - 'a']++;
                if (tempCount[c - 'a'] > 1) {
                    valid = false;
                    break;
                }
                wordScore += score[c - 'a'];
            }

            if (valid) {
                backtrack(idx + 1, currentScore + wordScore);
            }
        };

        backtrack(0, 0);
        return maxScore;
    }
};
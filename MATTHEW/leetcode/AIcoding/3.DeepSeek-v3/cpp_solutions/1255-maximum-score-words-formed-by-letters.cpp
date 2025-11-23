class Solution {
public:
    int maxScoreWords(vector<string>& words, vector<char>& letters, vector<int>& score) {
        vector<int> count(26, 0);
        for (char c : letters) {
            count[c - 'a']++;
        }
        return backtrack(words, count, score, 0);
    }

private:
    int backtrack(vector<string>& words, vector<int>& count, vector<int>& score, int index) {
        if (index == words.size()) {
            return 0;
        }
        int maxScore = backtrack(words, count, score, index + 1);
        vector<int> tempCount = count;
        bool valid = true;
        int currentScore = 0;
        for (char c : words[index]) {
            if (tempCount[c - 'a'] == 0) {
                valid = false;
                break;
            }
            tempCount[c - 'a']--;
            currentScore += score[c - 'a'];
        }
        if (valid) {
            currentScore += backtrack(words, tempCount, score, index + 1);
            maxScore = max(maxScore, currentScore);
        }
        return maxScore;
    }
};
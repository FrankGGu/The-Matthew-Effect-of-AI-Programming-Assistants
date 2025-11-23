#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxScoreWords(vector<string>& words, vector<char>& letters, vector<int>& score) {
        vector<int> letterCounts(26, 0);
        for (char c : letters) {
            letterCounts[c - 'a']++;
        }

        int maxScore = 0;
        int n = words.size();

        function<void(int, int, vector<int>)> solve = 
            [&](int index, int currentScore, vector<int> currentLetterCounts) {
            if (index == n) {
                maxScore = max(maxScore, currentScore);
                return;
            }

            solve(index + 1, currentScore, currentLetterCounts);

            string word = words[index];
            int wordScore = 0;
            vector<int> updatedLetterCounts = currentLetterCounts;
            bool canForm = true;

            for (char c : word) {
                int charIndex = c - 'a';
                if (updatedLetterCounts[charIndex] == 0) {
                    canForm = false;
                    break;
                }
                updatedLetterCounts[charIndex]--;
                wordScore += score[charIndex];
            }

            if (canForm) {
                solve(index + 1, currentScore + wordScore, updatedLetterCounts);
            }
        };

        solve(0, 0, letterCounts);
        return maxScore;
    }
};
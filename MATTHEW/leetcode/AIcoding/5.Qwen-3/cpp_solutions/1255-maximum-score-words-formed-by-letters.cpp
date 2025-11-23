#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxScoreWords(vector<string>& words, vector<char>& letters) {
        vector<int> count(26, 0);
        for (char c : letters) {
            count[c - 'a']++;
        }

        int result = 0;
        backtrack(words, count, 0, 0, result);
        return result;
    }

    void backtrack(vector<string>& words, vector<int>& count, int index, int score, int& result) {
        if (index == words.size()) {
            result = max(result, score);
            return;
        }

                backtrack(words, count, index + 1, score, result);

                bool canTake = true;
        for (char c : words[index]) {
            if (count[c - 'a'] == 0) {
                canTake = false;
                break;
            }
        }

        if (canTake) {
            for (char c : words[index]) {
                count[c - 'a']--;
            }

            int wordScore = 0;
            for (char c : words[index]) {
                wordScore += (c - 'a' + 1);
            }

            backtrack(words, count, index + 1, score + wordScore, result);

            for (char c : words[index]) {
                count[c - 'a']++;
            }
        }
    }
};
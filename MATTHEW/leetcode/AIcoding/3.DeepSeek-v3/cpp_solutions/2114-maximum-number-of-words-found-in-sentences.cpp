class Solution {
public:
    int mostWordsFound(vector<string>& sentences) {
        int maxWords = 0;
        for (const string& sentence : sentences) {
            int words = 1;
            for (char c : sentence) {
                if (c == ' ') {
                    words++;
                }
            }
            maxWords = max(maxWords, words);
        }
        return maxWords;
    }
};
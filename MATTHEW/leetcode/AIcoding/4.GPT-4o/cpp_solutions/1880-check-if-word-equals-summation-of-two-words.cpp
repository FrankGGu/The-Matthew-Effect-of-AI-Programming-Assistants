class Solution {
public:
    bool isSumEqual(string firstWord, string secondWord, string targetWord) {
        auto wordToNum = [](const string& word) {
            long long num = 0;
            for (char c : word) {
                num = num * 10 + (c - 'a');
            }
            return num;
        };
        return wordToNum(firstWord) + wordToNum(secondWord) == wordToNum(targetWord);
    }
};
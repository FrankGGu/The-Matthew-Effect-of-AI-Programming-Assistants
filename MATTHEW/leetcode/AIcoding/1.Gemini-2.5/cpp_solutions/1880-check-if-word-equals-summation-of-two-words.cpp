class Solution {
public:
    int wordToValue(const std::string& word) {
        int value = 0;
        for (char c : word) {
            value = value * 10 + (c - 'a');
        }
        return value;
    }

    bool isSumEqual(std::string firstWord, std::string secondWord, std::string targetWord) {
        return wordToValue(firstWord) + wordToValue(secondWord) == wordToValue(targetWord);
    }
};
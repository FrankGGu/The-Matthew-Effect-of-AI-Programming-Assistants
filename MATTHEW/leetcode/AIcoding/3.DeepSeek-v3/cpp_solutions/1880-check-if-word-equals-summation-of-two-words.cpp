class Solution {
public:
    bool isSumEqual(string firstWord, string secondWord, string targetWord) {
        auto wordToValue = [](const string& word) {
            int value = 0;
            for (char c : word) {
                value = value * 10 + (c - 'a');
            }
            return value;
        };

        int first = wordToValue(firstWord);
        int second = wordToValue(secondWord);
        int target = wordToValue(targetWord);

        return (first + second) == target;
    }
};
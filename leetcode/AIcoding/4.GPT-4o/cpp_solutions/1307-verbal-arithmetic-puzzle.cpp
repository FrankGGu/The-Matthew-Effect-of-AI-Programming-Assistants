class Solution {
public:
    bool isSumEqual(string firstWord, string secondWord, string targetWord) {
        auto wordToNumber = [](const string& word) {
            string number;
            for (char c : word) {
                number += to_string(c - 'a');
            }
            return number;
        };

        int firstNum = stoi(wordToNumber(firstWord));
        int secondNum = stoi(wordToNumber(secondWord));
        int targetNum = stoi(wordToNumber(targetWord));

        return firstNum + secondNum == targetNum;
    }
};
class Solution {
public:
    int uniqueMorseRepresentations(vector<string>& words) {
        vector<string> morse = { ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.." };
        unordered_set<string> uniqueMorse;

        for (const string& word : words) {
            string morseWord;
            for (char c : word) {
                morseWord += morse[c - 'a'];
            }
            uniqueMorse.insert(morseWord);
        }

        return uniqueMorse.size();
    }
};
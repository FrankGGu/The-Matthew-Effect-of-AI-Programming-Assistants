class Solution {
public:
    string toGoatLatin(string S) {
        stringstream ss(S);
        string word, result;
        int index = 1;
        while (ss >> word) {
            if (isVowel(word[0])) {
                word += "ma";
            } else {
                word = word.substr(1) + word[0] + "ma";
            }
            word += string(index++, 'a');
            result += word + " ";
        }
        result.pop_back();
        return result;
    }

    bool isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' || 
               c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U';
    }
};
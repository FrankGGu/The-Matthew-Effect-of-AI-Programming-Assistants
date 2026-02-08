class Solution {
public:
    string toGoatLatin(string S) {
        unordered_set<char> vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'};
        stringstream ss(S);
        string word, result;
        int count = 1;

        while (ss >> word) {
            if (vowels.find(word[0]) == vowels.end()) {
                word = word.substr(1) + word[0];
            }
            word += "ma" + string(count, 'a');
            if (!result.empty()) {
                result += " ";
            }
            result += word;
            count++;
        }

        return result;
    }
};
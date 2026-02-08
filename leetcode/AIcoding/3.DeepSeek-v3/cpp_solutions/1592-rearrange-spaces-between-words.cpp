class Solution {
public:
    string reorderSpaces(string text) {
        int spaceCount = 0;
        vector<string> words;
        string currentWord;

        for (char c : text) {
            if (c == ' ') {
                spaceCount++;
                if (!currentWord.empty()) {
                    words.push_back(currentWord);
                    currentWord.clear();
                }
            } else {
                currentWord += c;
            }
        }
        if (!currentWord.empty()) {
            words.push_back(currentWord);
        }

        if (words.size() == 1) {
            return words[0] + string(spaceCount, ' ');
        }

        int gap = spaceCount / (words.size() - 1);
        int trailing = spaceCount % (words.size() - 1);

        string result;
        for (int i = 0; i < words.size(); ++i) {
            result += words[i];
            if (i != words.size() - 1) {
                result += string(gap, ' ');
            }
        }
        result += string(trailing, ' ');

        return result;
    }
};
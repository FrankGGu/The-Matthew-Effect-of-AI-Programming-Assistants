class Solution {
public:
    string arrangeWords(string text) {
        if (text.empty()) return text;
        text[0] = tolower(text[0]);
        vector<string> words;
        stringstream ss(text);
        string word;
        while (ss >> word) {
            words.push_back(word);
        }
        stable_sort(words.begin(), words.end(), [](const string& a, const string& b) {
            return a.size() < b.size();
        });
        string result;
        for (int i = 0; i < words.size(); ++i) {
            if (i == 0) {
                words[i][0] = toupper(words[i][0]);
            } else {
                if (i != 0) result += " ";
            }
            result += words[i];
        }
        return result;
    }
};
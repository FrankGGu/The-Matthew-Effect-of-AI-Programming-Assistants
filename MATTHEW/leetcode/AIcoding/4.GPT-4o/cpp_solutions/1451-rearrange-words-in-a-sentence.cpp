class Solution {
public:
    string arrangeWords(string text) {
        transform(text.begin(), text.end(), text.begin(), ::tolower);
        istringstream iss(text);
        vector<string> words;
        string word;

        while (iss >> word) {
            words.push_back(word);
        }

        sort(words.begin(), words.end(), [](const string &a, const string &b) {
            return a.size() < b.size();
        });

        string result;
        for (const string &w : words) {
            result += w + " ";
        }

        result.pop_back();
        result[0] = toupper(result[0]);

        return result;
    }
};
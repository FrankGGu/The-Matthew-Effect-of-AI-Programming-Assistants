class Solution {
public:
    string sortSentence(string s) {
        vector<string> words;
        string current;
        for (char c : s) {
            if (c == ' ') {
                words.push_back(current);
                current.clear();
            } else {
                current += c;
            }
        }
        if (!current.empty()) {
            words.push_back(current);
        }

        vector<string> sorted(words.size());
        for (const string& word : words) {
            int pos = word.back() - '1';
            sorted[pos] = word.substr(0, word.size() - 1);
        }

        string result;
        for (const string& word : sorted) {
            if (!result.empty()) {
                result += " ";
            }
            result += word;
        }
        return result;
    }
};
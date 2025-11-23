class Solution {
public:
    string replaceWords(vector<string>& dictionary, string sentence) {
        unordered_set<string> dict(dictionary.begin(), dictionary.end());
        istringstream iss(sentence);
        string word;
        string result;
        while (iss >> word) {
            string prefix;
            for (int i = 1; i <= word.size(); ++i) {
                prefix = word.substr(0, i);
                if (dict.find(prefix) != dict.end()) {
                    break;
                }
            }
            if (!result.empty()) {
                result += " ";
            }
            result += prefix;
        }
        return result;
    }
};
class Solution {
public:
    string replaceWords(vector<string>& dict, string sentence) {
        unordered_set<string> prefixes(dict.begin(), dict.end());
        istringstream iss(sentence);
        string word, result;
        while (iss >> word) {
            string root = word;
            for (int len = 1; len <= word.size(); ++len) {
                if (prefixes.count(word.substr(0, len))) {
                    root = word.substr(0, len);
                    break;
                }
            }
            result += (result.empty() ? "" : " ") + root;
        }
        return result;
    }
};
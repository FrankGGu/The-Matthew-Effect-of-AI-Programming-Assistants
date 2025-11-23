class Solution {
public:
    string findReplaceString(string s, vector<int>& indices, vector<string>& sources, vector<string>& targets) {
        map<int, pair<string, string>> replacements;
        for (int i = 0; i < indices.size(); i++) {
            replacements[indices[i]] = {sources[i], targets[i]};
        }

        string result;
        int lastIndex = 0;
        for (auto& [index, replacement] : replacements) {
            result += s.substr(lastIndex, index - lastIndex);
            if (s.substr(index, replacement.first.length()) == replacement.first) {
                result += replacement.second;
            } else {
                result += s.substr(index, replacement.first.length());
            }
            lastIndex = index + replacement.first.length();
        }
        result += s.substr(lastIndex);

        return result;
    }
};
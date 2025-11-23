class Solution {
public:
    string evaluate(string s, vector<vector<string>>& knowledge) {
        unordered_map<string, string> dict;
        for (const auto& pair : knowledge) {
            dict[pair[0]] = pair[1];
        }
        string res;
        int i = 0;
        int n = s.size();
        while (i < n) {
            if (s[i] == '(') {
                i++;
                string key;
                while (i < n && s[i] != ')') {
                    key += s[i];
                    i++;
                }
                if (dict.count(key)) {
                    res += dict[key];
                } else {
                    res += '?';
                }
                i++;
            } else {
                res += s[i];
                i++;
            }
        }
        return res;
    }
};
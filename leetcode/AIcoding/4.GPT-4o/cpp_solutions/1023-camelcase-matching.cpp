class Solution {
public:
    vector<bool> camelMatch(vector<string>& queries, string pattern) {
        vector<bool> result;
        for (const string& query : queries) {
            int j = 0;
            bool match = true;
            for (int i = 0; i < query.size(); ++i) {
                if (j < pattern.size() && query[i] == pattern[j]) {
                    j++;
                } else if (isupper(query[i])) {
                    match = false;
                    break;
                }
            }
            if (match && j == pattern.size()) {
                result.push_back(true);
            } else {
                result.push_back(false);
            }
        }
        return result;
    }
};
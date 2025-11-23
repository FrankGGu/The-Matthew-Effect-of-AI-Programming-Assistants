class Solution {
public:
    string oddString(vector<string>& words) {
        unordered_map<string, vector<string>> mp;
        for (auto& word : words) {
            string key;
            for (int i = 1; i < word.size(); ++i) {
                key += to_string(word[i] - word[i - 1]) + ",";
            }
            mp[key].push_back(word);
        }
        for (auto& [key, vec] : mp) {
            if (vec.size() == 1) {
                return vec[0];
            }
        }
        return "";
    }
};
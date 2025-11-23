class Solution {
public:
    string shortestCompletingWord(string licensePlate, vector<string>& words) {
        vector<int> target(26, 0);
        for (char c : licensePlate) {
            if (isalpha(c)) {
                target[tolower(c) - 'a']++;
            }
        }

        string result;
        for (string word : words) {
            vector<int> count(26, 0);
            for (char c : word) {
                count[tolower(c) - 'a']++;
            }

            bool valid = true;
            for (int i = 0; i < 26; ++i) {
                if (count[i] < target[i]) {
                    valid = false;
                    break;
                }
            }

            if (valid && (result.empty() || word.size() < result.size())) {
                result = word;
            }
        }

        return result;
    }
};
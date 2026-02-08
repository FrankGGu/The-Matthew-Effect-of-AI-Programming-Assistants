class Solution {
public:
    string minimizeStringValue(string s) {
        vector<int> freq(26, 0);
        vector<int> questionIndices;
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] != '?') {
                freq[s[i] - 'a']++;
            } else {
                questionIndices.push_back(i);
            }
        }

        vector<pair<int, char>> chars;
        for (char c = 'a'; c <= 'z'; ++c) {
            chars.emplace_back(freq[c - 'a'], c);
        }

        vector<char> selectedChars;
        for (int i = 0; i < questionIndices.size(); ++i) {
            sort(chars.begin(), chars.end());
            selectedChars.push_back(chars[0].second);
            chars[0].first++;
        }

        sort(selectedChars.begin(), selectedChars.end());
        for (int i = 0; i < questionIndices.size(); ++i) {
            s[questionIndices[i]] = selectedChars[i];
        }

        return s;
    }
};
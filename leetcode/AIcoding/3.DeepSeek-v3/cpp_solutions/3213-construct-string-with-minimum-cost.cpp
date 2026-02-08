class Solution {
public:
    string minimizeStringValue(string s) {
        vector<int> freq(26, 0);
        for (char c : s) {
            if (c != '?') {
                freq[c - 'a']++;
            }
        }
        vector<char> toFill;
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] == '?') {
                int minFreq = INT_MAX;
                char bestChar = 'a';
                for (char c = 'a'; c <= 'z'; ++c) {
                    if (freq[c - 'a'] < minFreq) {
                        minFreq = freq[c - 'a'];
                        bestChar = c;
                    }
                }
                toFill.push_back(bestChar);
                freq[bestChar - 'a']++;
            }
        }
        sort(toFill.begin(), toFill.end());
        int idx = 0;
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] == '?') {
                s[i] = toFill[idx++];
            }
        }
        return s;
    }
};
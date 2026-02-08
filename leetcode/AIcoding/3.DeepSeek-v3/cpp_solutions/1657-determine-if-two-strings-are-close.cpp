class Solution {
public:
    bool closeStrings(string word1, string word2) {
        if (word1.size() != word2.size()) {
            return false;
        }

        vector<int> freq1(26, 0), freq2(26, 0);
        vector<bool> present1(26, false), present2(26, false);

        for (char c : word1) {
            freq1[c - 'a']++;
            present1[c - 'a'] = true;
        }

        for (char c : word2) {
            freq2[c - 'a']++;
            present2[c - 'a'] = true;
        }

        sort(freq1.begin(), freq1.end());
        sort(freq2.begin(), freq2.end());

        return freq1 == freq2 && present1 == present2;
    }
};
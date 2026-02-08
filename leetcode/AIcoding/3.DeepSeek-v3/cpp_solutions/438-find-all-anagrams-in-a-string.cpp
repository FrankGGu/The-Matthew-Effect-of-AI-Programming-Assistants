class Solution {
public:
    vector<int> findAnagrams(string s, string p) {
        vector<int> result;
        if (s.empty() || p.empty() || s.size() < p.size()) return result;

        vector<int> pCount(26, 0);
        vector<int> sCount(26, 0);

        for (char c : p) {
            pCount[c - 'a']++;
        }

        int windowSize = p.size();
        for (int i = 0; i < windowSize; ++i) {
            sCount[s[i] - 'a']++;
        }

        if (pCount == sCount) {
            result.push_back(0);
        }

        for (int i = windowSize; i < s.size(); ++i) {
            sCount[s[i - windowSize] - 'a']--;
            sCount[s[i] - 'a']++;

            if (pCount == sCount) {
                result.push_back(i - windowSize + 1);
            }
        }

        return result;
    }
};
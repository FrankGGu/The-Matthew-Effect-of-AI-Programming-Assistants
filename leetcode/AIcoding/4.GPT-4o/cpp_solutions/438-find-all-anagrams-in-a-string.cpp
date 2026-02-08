class Solution {
public:
    vector<int> findAnagrams(string s, string p) {
        vector<int> result;
        if (s.size() < p.size()) return result;

        vector<int> pCount(26, 0), sCount(26, 0);
        for (char c : p) pCount[c - 'a']++;

        for (int i = 0; i < p.size(); i++) {
            sCount[s[i] - 'a']++;
        }

        if (sCount == pCount) result.push_back(0);

        for (int i = p.size(); i < s.size(); i++) {
            sCount[s[i] - 'a']++;
            sCount[s[i - p.size()] - 'a']--;
            if (sCount == pCount) result.push_back(i - p.size() + 1);
        }

        return result;
    }
};
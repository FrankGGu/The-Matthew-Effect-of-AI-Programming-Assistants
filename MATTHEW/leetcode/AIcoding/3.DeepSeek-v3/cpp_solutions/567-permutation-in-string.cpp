class Solution {
public:
    bool checkInclusion(string s1, string s2) {
        if (s1.size() > s2.size()) return false;
        vector<int> s1Count(26, 0), s2Count(26, 0);
        for (int i = 0; i < s1.size(); ++i) {
            s1Count[s1[i] - 'a']++;
            s2Count[s2[i] - 'a']++;
        }
        int matches = 0;
        for (int i = 0; i < 26; ++i) {
            if (s1Count[i] == s2Count[i]) matches++;
        }
        for (int i = s1.size(); i < s2.size(); ++i) {
            if (matches == 26) return true;
            int left = s2[i - s1.size()] - 'a';
            s2Count[left]--;
            if (s2Count[left] == s1Count[left]) matches++;
            else if (s2Count[left] == s1Count[left] - 1) matches--;
            int right = s2[i] - 'a';
            s2Count[right]++;
            if (s2Count[right] == s1Count[right]) matches++;
            else if (s2Count[right] == s1Count[right] + 1) matches--;
        }
        return matches == 26;
    }
};
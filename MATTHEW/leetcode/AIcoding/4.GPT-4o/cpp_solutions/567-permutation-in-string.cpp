class Solution {
public:
    bool checkInclusion(string s1, string s2) {
        vector<int> count(26, 0), window(26, 0);
        for (char c : s1) count[c - 'a']++;
        int left = 0, right = 0, s1Length = s1.size(), s2Length = s2.size();

        while (right < s2Length) {
            window[s2[right] - 'a']++;
            if (right - left + 1 > s1Length) {
                window[s2[left] - 'a']--;
                left++;
            }
            if (window == count) return true;
            right++;
        }
        return false;
    }
};
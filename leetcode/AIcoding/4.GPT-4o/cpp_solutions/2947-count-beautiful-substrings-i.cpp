class Solution {
public:
    int countBeautifulSubstrings(string s) {
        int count = 0, n = s.size();
        for (int i = 0; i < n; ++i) {
            int aCount = 0, bCount = 0;
            for (int j = i; j < n; ++j) {
                if (s[j] == 'a') aCount++;
                else if (s[j] == 'b') bCount++;
                if (aCount == bCount) count++;
            }
        }
        return count;
    }
};
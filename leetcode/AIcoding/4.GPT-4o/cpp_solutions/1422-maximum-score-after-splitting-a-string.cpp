class Solution {
public:
    int maxScore(string s) {
        int count0 = 0, count1 = 0;
        for (char c : s) {
            if (c == '1') count1++;
        }
        int maxScore = count1;
        for (int i = 0; i < s.size() - 1; i++) {
            if (s[i] == '0') count0++;
            else count1--;
            maxScore = max(maxScore, count0 + count1);
        }
        return maxScore;
    }
};
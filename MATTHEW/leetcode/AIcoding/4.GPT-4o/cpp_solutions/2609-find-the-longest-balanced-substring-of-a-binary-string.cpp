class Solution {
public:
    int findTheLongestBalancedSubstring(string s) {
        int maxLength = 0;
        int n = s.size();

        for (int i = 0; i < n; i++) {
            if (s[i] == '0') {
                int count0 = 0, count1 = 0;
                while (i < n && s[i] == '0') {
                    count0++;
                    i++;
                }
                while (i < n && s[i] == '1') {
                    count1++;
                    i++;
                }
                maxLength = max(maxLength, 2 * min(count0, count1));
            }
        }

        return maxLength;
    }
};
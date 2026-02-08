class Solution {
public:
    int secondsToRemoveOccurrences(string s) {
        int seconds = 0;
        while (s.find("01") != string::npos) {
            for (int i = 0; i < s.size() - 1; ++i) {
                if (s[i] == '0' && s[i + 1] == '1') {
                    s[i] = '1';
                    s[i + 1] = '0';
                    i++; // Skip the next position as we just moved '0' to it
                }
            }
            seconds++;
        }
        return seconds;
    }
};
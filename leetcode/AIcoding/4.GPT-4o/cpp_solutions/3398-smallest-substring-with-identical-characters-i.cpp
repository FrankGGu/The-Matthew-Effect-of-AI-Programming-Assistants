class Solution {
public:
    string smallestSubstring(string s) {
        int n = s.size();
        int minLength = n + 1;
        string result = "";

        for (int i = 0; i < n; i++) {
            int j = i;
            while (j < n && s[j] == s[i]) {
                j++;
            }
            if (j - i < minLength) {
                minLength = j - i;
                result = s.substr(i, minLength);
            }
            i = j - 1; // move to the end of the current group
        }

        return result;
    }
};
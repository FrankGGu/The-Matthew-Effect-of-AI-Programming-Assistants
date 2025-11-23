class Solution {
public:
    string reverseWords(string s) {
        string result;
        int i = 0;
        int n = s.size();

        while (i < n) {
            while (i < n && s[i] == ' ') i++;
            if (i >= n) break;
            int j = i + 1;
            while (j < n && s[j] != ' ') j++;
            string word = s.substr(i, j - i);
            if (result.empty()) {
                result = word;
            } else {
                result = word + " " + result;
            }
            i = j + 1;
        }

        return result;
    }
};
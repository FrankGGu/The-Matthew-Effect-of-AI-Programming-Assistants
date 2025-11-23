class Solution {
public:
    string findLongestWord(string s, vector<string>& dictionary) {
        string result = "";
        for (string word : dictionary) {
            if (isSubsequence(word, s)) {
                if (word.length() > result.length() || 
                    (word.length() == result.length() && word < result)) {
                    result = word;
                }
            }
        }
        return result;
    }

private:
    bool isSubsequence(string word, string s) {
        int i = 0, j = 0;
        while (i < word.length() && j < s.length()) {
            if (word[i] == s[j]) {
                i++;
            }
            j++;
        }
        return i == word.length();
    }
};
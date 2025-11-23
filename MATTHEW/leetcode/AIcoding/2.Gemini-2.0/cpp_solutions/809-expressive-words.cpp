#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int expressiveWords(string s, vector<string>& words) {
        int count = 0;
        for (string& word : words) {
            if (isStretchy(s, word)) {
                count++;
            }
        }
        return count;
    }

private:
    bool isStretchy(string s, string word) {
        int i = 0, j = 0;
        while (i < s.length() && j < word.length()) {
            if (s[i] != word[j]) {
                return false;
            }
            char c = s[i];
            int cntS = 0, cntW = 0;
            while (i < s.length() && s[i] == c) {
                cntS++;
                i++;
            }
            while (j < word.length() && word[j] == c) {
                cntW++;
                j++;
            }
            if (cntS < cntW) {
                return false;
            }
            if (cntS > cntW && cntS < 3) {
                return false;
            }
        }
        return i == s.length() && j == word.length();
    }
};
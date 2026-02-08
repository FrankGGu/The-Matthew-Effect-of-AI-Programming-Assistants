#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string findLongestWord(string s, vector<string>& dictionary) {
        string longestWord = "";
        for (string word : dictionary) {
            int i = 0, j = 0;
            while (i < s.length() && j < word.length()) {
                if (s[i] == word[j]) {
                    j++;
                }
                i++;
            }
            if (j == word.length()) {
                if (word.length() > longestWord.length()) {
                    longestWord = word;
                } else if (word.length() == longestWord.length() && word < longestWord) {
                    longestWord = word;
                }
            }
        }
        return longestWord;
    }
};
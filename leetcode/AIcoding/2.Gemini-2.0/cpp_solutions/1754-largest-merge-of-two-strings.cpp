#include <string>

using namespace std;

class Solution {
public:
    string largestMerge(string word1, string word2) {
        string result = "";
        int i = 0, j = 0;
        while (i < word1.length() || j < word2.length()) {
            if (i < word1.length() && j < word2.length()) {
                if (word1.substr(i) > word2.substr(j)) {
                    result += word1[i++];
                } else {
                    result += word2[j++];
                }
            } else if (i < word1.length()) {
                result += word1[i++];
            } else {
                result += word2[j++];
            }
        }
        return result;
    }
};
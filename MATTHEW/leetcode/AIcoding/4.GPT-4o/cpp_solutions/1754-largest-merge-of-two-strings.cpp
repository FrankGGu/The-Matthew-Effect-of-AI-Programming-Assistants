#include <string>

using namespace std;

class Solution {
public:
    string largestMerge(string word1, string word2) {
        string result;
        while (!word1.empty() && !word2.empty()) {
            if (word1 > word2) {
                result += word1[0];
                word1.erase(word1.begin());
            } else {
                result += word2[0];
                word2.erase(word2.begin());
            }
        }
        result += word1;
        result += word2;
        return result;
    }
};
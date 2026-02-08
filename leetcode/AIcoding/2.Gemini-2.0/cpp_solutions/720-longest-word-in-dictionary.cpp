#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string longestWord(vector<string>& words) {
        sort(words.begin(), words.end());
        string longest = "";
        vector<string> built;
        for (string word : words) {
            if (word.length() == 1 || find(built.begin(), built.end(), word.substr(0, word.length() - 1)) != built.end()) {
                built.push_back(word);
                if (word.length() > longest.length()) {
                    longest = word;
                }
            }
        }
        return longest;
    }
};
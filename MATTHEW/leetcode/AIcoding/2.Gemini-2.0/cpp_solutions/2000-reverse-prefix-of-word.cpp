#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string reversePrefix(string word, char ch) {
        int index = -1;
        for (int i = 0; i < word.length(); ++i) {
            if (word[i] == ch) {
                index = i;
                break;
            }
        }

        if (index != -1) {
            reverse(word.begin(), word.begin() + index + 1);
        }

        return word;
    }
};
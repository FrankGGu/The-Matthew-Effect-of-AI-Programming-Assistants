#include <iostream>
#include <string>

using namespace std;

class Solution {
public:
    bool detectCapital(string word) {
        int count = 0;
        for (char c : word) {
            if (isupper(c)) {
                count++;
            }
        }
        return count == 0 || count == 1 && isupper(word[0]) || count == word.length();
    }
};
#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countVowels(string word) {
        int n = word.length();
        int result = 0;
        for (int i = 0; i < n; ++i) {
            if (word[i] == 'a' || word[i] == 'e' || word[i] == 'i' || word[i] == 'o' || word[i] == 'u') {
                result += (i + 1) * (n - i);
            }
        }
        return result;
    }
};
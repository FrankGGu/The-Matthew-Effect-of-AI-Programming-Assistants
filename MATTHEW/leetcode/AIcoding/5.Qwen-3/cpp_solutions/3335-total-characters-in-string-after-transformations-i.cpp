#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numberOfSpecialChars(string word) {
        vector<int> freq(26, 0);
        for (char c : word) {
            if (islower(c)) {
                freq[c - 'a']++;
            }
        }
        int count = 0;
        for (int i = 0; i < 26; ++i) {
            if (freq[i] > 0) {
                count++;
            }
        }
        return count;
    }
};
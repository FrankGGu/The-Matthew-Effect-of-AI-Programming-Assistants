#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> findWordsContaining(string word, char x) {
        vector<int> result;
        for (int i = 0; i < word.length(); ++i) {
            if (word[i] == x) {
                result.push_back(i);
            }
        }
        return result;
    }
};
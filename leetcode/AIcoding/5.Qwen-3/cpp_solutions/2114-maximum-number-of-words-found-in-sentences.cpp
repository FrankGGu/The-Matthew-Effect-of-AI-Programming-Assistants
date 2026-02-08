#include <iostream>
#include <vector>
#include <string>
#include <sstream>

using namespace std;

class Solution {
public:
    int mostWordsFound(vector<string>& sentences) {
        int maxWords = 0;
        for (const string& sentence : sentences) {
            stringstream ss(sentence);
            int wordCount = 0;
            string word;
            while (ss >> word) {
                ++wordCount;
            }
            maxWords = max(maxWords, wordCount);
        }
        return maxWords;
    }
};
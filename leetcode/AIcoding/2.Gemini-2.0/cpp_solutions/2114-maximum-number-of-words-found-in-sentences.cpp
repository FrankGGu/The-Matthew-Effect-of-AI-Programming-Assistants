#include <string>
#include <vector>
#include <sstream>
#include <algorithm>

using namespace std;

class Solution {
public:
    int mostWordsFound(vector<string>& sentences) {
        int max_words = 0;
        for (const string& sentence : sentences) {
            stringstream ss(sentence);
            string word;
            int word_count = 0;
            while (ss >> word) {
                word_count++;
            }
            max_words = max(max_words, word_count);
        }
        return max_words;
    }
};
#include <string>
#include <vector>
#include <sstream>
#include <algorithm>

using namespace std;

class Solution {
public:
    int mostWords(string s) {
        istringstream iss(s);
        string word;
        int maxWords = 0;

        while (iss >> word) {
            maxWords++;
        }

        return maxWords;
    }

    int mostWordsInSentences(vector<string>& sentences) {
        int maxWords = 0;
        for (const string& sentence : sentences) {
            maxWords = max(maxWords, mostWords(sentence));
        }
        return maxWords;
    }
};
#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int wordCount(vector<string>& startWords, vector<string>& targetWords) {
        unordered_set<string> startWordSet;
        for (string& word : startWords) {
            sort(word.begin(), word.end());
            startWordSet.insert(word);
        }

        int count = 0;
        for (string& targetWord : targetWords) {
            sort(targetWord.begin(), targetWord.end());
            for (int i = 0; i < targetWord.length(); ++i) {
                string temp = targetWord;
                temp.erase(i, 1);
                if (startWordSet.count(temp)) {
                    count++;
                    break;
                }
            }
        }

        return count;
    }
};
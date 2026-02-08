#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string replaceWords(vector<string>& dictionary, string sentence) {
        unordered_map<string, int> wordMap;
        for (const string& word : dictionary) {
            wordMap[word] = 1;
        }

        string result;
        string word;
        for (char c : sentence) {
            if (c == ' ') {
                result += word + " ";
                word.clear();
            } else {
                word += c;
                if (wordMap.find(word) != wordMap.end()) {
                    result += word + " ";
                    word.clear();
                }
            }
        }
        result += word;
        return result;
    }
};
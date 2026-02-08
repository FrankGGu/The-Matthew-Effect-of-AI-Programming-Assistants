#include <vector>
#include <string>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string shortestCompletingWord(string licensePlate, vector<string>& words) {
        unordered_map<char, int> plateFreq;
        for (char c : licensePlate) {
            if (isalpha(c)) {
                plateFreq[tolower(c)]++;
            }
        }

        string shortestWord = "";
        int minLength = INT_MAX;

        for (string word : words) {
            unordered_map<char, int> wordFreq;
            for (char c : word) {
                wordFreq[c]++;
            }

            bool complete = true;
            for (auto const& [key, val] : plateFreq) {
                if (wordFreq.find(key) == wordFreq.end() || wordFreq[key] < val) {
                    complete = false;
                    break;
                }
            }

            if (complete) {
                if (word.length() < minLength) {
                    minLength = word.length();
                    shortestWord = word;
                }
            }
        }

        return shortestWord;
    }
};
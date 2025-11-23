#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countCharacters(vector<string>& words, string chars) {
        unordered_map<char, int> charCount;
        for (char c : chars) {
            charCount[c]++;
        }

        int count = 0;
        for (string word : words) {
            unordered_map<char, int> wordCount;
            bool good = true;
            for (char c : word) {
                wordCount[c]++;
                if (wordCount[c] > charCount[c]) {
                    good = false;
                    break;
                }
            }
            if (good) {
                count += word.length();
            }
        }

        return count;
    }
};
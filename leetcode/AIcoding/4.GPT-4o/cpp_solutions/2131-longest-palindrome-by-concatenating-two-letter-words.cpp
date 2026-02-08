#include <vector>
#include <string>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int longestPalindrome(vector<string>& words) {
        unordered_map<string, int> count;
        int length = 0;
        bool hasOdd = false;

        for (const auto& word : words) {
            count[word]++;
        }

        for (const auto& entry : count) {
            string word = entry.first;
            if (word[0] == word[1]) {
                length += (entry.second / 2) * 4;
                if (entry.second % 2 == 1) hasOdd = true;
            } else {
                string reverseWord = string(1, word[1]) + word[0];
                if (count.count(reverseWord)) {
                    length += min(entry.second, count[reverseWord]) * 4;
                }
            }
        }

        if (hasOdd) length += 2;

        return length;
    }
};
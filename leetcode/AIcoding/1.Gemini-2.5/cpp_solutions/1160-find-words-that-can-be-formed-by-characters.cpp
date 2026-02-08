#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countCharacters(vector<string>& words, string chars) {
        unordered_map<char, int> char_counts;
        for (char c : chars) {
            char_counts[c]++;
        }

        int count = 0;
        for (string& word : words) {
            unordered_map<char, int> word_counts;
            bool possible = true;
            for (char c : word) {
                word_counts[c]++;
            }

            for (auto const& [key, val] : word_counts) {
                if (char_counts.find(key) == char_counts.end() || char_counts[key] < val) {
                    possible = false;
                    break;
                }
            }

            if (possible) {
                count += word.length();
            }
        }

        return count;
    }
};
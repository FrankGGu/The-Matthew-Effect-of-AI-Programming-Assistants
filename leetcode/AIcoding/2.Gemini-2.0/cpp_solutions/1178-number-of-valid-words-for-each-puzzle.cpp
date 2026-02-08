#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> findNumOfValidWords(vector<string>& words, vector<string>& puzzles) {
        unordered_map<int, int> word_mask_count;
        for (string& word : words) {
            int mask = 0;
            for (char c : word) {
                mask |= (1 << (c - 'a'));
            }
            bool valid = true;
            for (int i = 0; i < 26; ++i) {
                if ((mask & (1 << i)) && __builtin_popcount(mask) > 7) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                word_mask_count[mask]++;
            }
        }

        vector<int> result;
        for (string& puzzle : puzzles) {
            int count = 0;
            int first_char_mask = (1 << (puzzle[0] - 'a'));
            for (int mask = 0; mask < (1 << 26); ++mask) {
                if ((mask & first_char_mask) && __builtin_popcount(mask) <= 7) {
                    bool valid = true;
                    for (int i = 0; i < 26; ++i) {
                        if ((mask & (1 << i))) {
                            bool found = false;
                            for (char c : puzzle) {
                                if (c - 'a' == i) {
                                    found = true;
                                    break;
                                }
                            }
                            if (!found) {
                                valid = false;
                                break;
                            }
                        }
                    }
                    if (valid) {
                        count += word_mask_count[mask];
                    }
                }
            }
            result.push_back(count);
        }

        return result;
    }
};
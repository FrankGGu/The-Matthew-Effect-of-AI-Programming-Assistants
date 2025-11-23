#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> findNumOfValidWords(vector<string>& words, vector<string>& puzzles) {
        unordered_map<int, int> wordMaskCounts;
        for (const string& word : words) {
            int mask = 0;
            for (char c : word) {
                mask |= (1 << (c - 'a'));
            }
            if (__builtin_popcount(mask) <= 7) {
                wordMaskCounts[mask]++;
            }
        }

        vector<int> result;
        for (const string& puzzle : puzzles) {
            int count = 0;
            int firstCharMask = (1 << (puzzle[0] - 'a'));
            for (int mask = 0; mask < (1 << 26); ++mask) {
                if (__builtin_popcount(mask) <= 7) {
                    if ((mask & firstCharMask) && (mask & ((1 << 26) - 1)) == mask) {
                        bool valid = true;
                        for (int i = 0; i < 26; ++i) {
                            if ((mask >> i) & 1) {
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

                        if (valid && wordMaskCounts.count(mask)) {
                            count += wordMaskCounts[mask];
                        }
                    }
                }

            }

            int puzzleMask = 0;
            for(char c : puzzle){
                puzzleMask |= (1 << (c - 'a'));
            }

            int currentCount = 0;
            for (auto const& [wordMask, wordCount] : wordMaskCounts) {
                if ((wordMask & firstCharMask) && ((wordMask & puzzleMask) == wordMask)){
                    currentCount += wordCount;
                }
            }
            result.push_back(currentCount);
        }

        return result;
    }
};
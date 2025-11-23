#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <bitset>

using namespace std;

class Solution {
public:
    vector<int> findNumOfValidWords(vector<string>& words, vector<string>& puzzles) {
        unordered_map<int, int> freq;
        for (const string& word : words) {
            int mask = 0;
            for (char c : word) {
                mask |= 1 << (c - 'a');
            }
            freq[mask]++;
        }

        vector<int> result;
        for (const string& puzzle : puzzles) {
            int count = 0;
            int first = 1 << (puzzle[0] - 'a');
            int mask = 0;
            for (char c : puzzle) {
                mask |= 1 << (c - 'a');
            }

            int submask = mask;
            do {
                if (submask & first) {
                    count += freq[submask];
                }
                submask = (submask - 1) & mask;
            } while (submask != mask);

            result.push_back(count);
        }

        return result;
    }
};
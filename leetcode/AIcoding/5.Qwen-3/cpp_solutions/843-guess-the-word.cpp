#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>
#include <random>

using namespace std;

class Solution {
public:
    void findWord(vector<string>& wordList, int& numGuesses) {
        vector<string> candidates = wordList;
        random_device rd;
        mt19937 rng(rd());
        uniform_int_distribution<int> dist(0, candidates.size() - 1);

        for (int i = 0; i < 10; ++i) {
            string guess = candidates[dist(rng)];
            int match = getMatch(guess, wordList);
            if (match == 6) break;
            vector<string> newCandidates;
            for (const string& candidate : candidates) {
                if (getMatch(candidate, guess) == match) {
                    newCandidates.push_back(candidate);
                }
            }
            candidates = newCandidates;
            if (candidates.empty()) break;
        }
    }

private:
    int getMatch(const string& a, const string& b) {
        int match = 0;
        for (int i = 0; i < 6; ++i) {
            if (a[i] == b[i]) ++match;
        }
        return match;
    }
};
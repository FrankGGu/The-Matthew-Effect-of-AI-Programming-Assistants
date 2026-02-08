#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minDeletionsToRemoveToMakeKSpecial(string s, int k) {
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        vector<int> counts;
        for (auto& [c, cnt] : freq) {
            counts.push_back(cnt);
        }

        int deletions = 0;
        for (int i = 0; i < counts.size(); ++i) {
            int remainder = counts[i] % k;
            if (remainder != 0) {
                deletions += remainder;
            }
        }

        return deletions;
    }
};
#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minDeletions(string s, int k) {
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        vector<int> counts;
        for (auto& p : freq) {
            counts.push_back(p.second);
        }

        sort(counts.begin(), counts.end(), greater<int>());

        int deletions = 0;
        for (int i = 1; i < counts.size(); ++i) {
            while (counts[i] > 0 && counts[i] + deletions > counts[0] - k) {
                counts[i]--;
                deletions++;
            }
        }

        return deletions;
    }
};
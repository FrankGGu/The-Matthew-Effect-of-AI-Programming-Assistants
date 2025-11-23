#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int countKSubsequenceMaxBeauty(string s, int k) {
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        vector<pair<int, char>> sortedFreq;
        for (auto& [c, count] : freq) {
            sortedFreq.push_back({count, c});
        }

        sort(sortedFreq.begin(), sortedFreq.end(), greater<pair<int, char>>());

        long long result = 1;
        int total = 0;
        for (auto& [count, c] : sortedFreq) {
            total += count;
        }

        if (total < k) return 0;

        int needed = k;
        vector<long long> counts;
        vector<char> chars;

        for (auto& [count, c] : sortedFreq) {
            if (needed > 0) {
                counts.push_back(count);
                chars.push_back(c);
                needed -= count;
            } else {
                break;
            }
        }

        if (needed != 0) {
            int remaining = k - (k - needed);
            int extra = needed;
            for (int i = 0; i < counts.size(); ++i) {
                if (extra > 0) {
                    counts[i] += 1;
                    extra--;
                }
            }
        }

        for (int i = 0; i < counts.size(); ++i) {
            result = (result * counts[i]) % 1000000007;
        }

        return static_cast<int>(result);
    }
};
#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool equalizeFrequency(string s) {
        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        for (int i = 0; i < 26; ++i) {
            if (freq[i] == 0) continue;
            freq[i]--;
            bool valid = true;
            int first = 0;
            for (int j = 0; j < 26; ++j) {
                if (freq[j] > 0) {
                    if (first == 0) {
                        first = freq[j];
                    } else if (freq[j] != first) {
                        valid = false;
                        break;
                    }
                }
            }
            if (valid) return true;
            freq[i]++;
        }
        return false;
    }
};
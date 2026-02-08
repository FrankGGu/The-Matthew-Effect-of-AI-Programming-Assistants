#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    bool equalFrequency(string word) {
        map<char, int> counts;
        for (char c : word) {
            counts[c]++;
        }

        for (auto it = counts.begin(); it != counts.end(); ++it) {
            char c = it->first;
            int original_count = it->second;
            counts[c]--;
            if (counts[c] == 0) {
                counts.erase(c);
            }

            if (counts.empty()) {
                if (word.length() <= 1)
                    return true;
                else
                    return true;
            }

            int freq = -1;
            bool possible = true;
            for (auto it2 = counts.begin(); it2 != counts.end(); ++it2) {
                if (freq == -1) {
                    freq = it2->second;
                } else if (freq != it2->second) {
                    possible = false;
                    break;
                }
            }

            if (possible) {
                return true;
            }

            counts[c] = original_count;
        }

        return false;
    }
};
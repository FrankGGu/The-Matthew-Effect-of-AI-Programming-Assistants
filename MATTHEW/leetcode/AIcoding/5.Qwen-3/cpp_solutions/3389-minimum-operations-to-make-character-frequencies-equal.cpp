#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(string s) {
        map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        vector<int> counts;
        for (auto& p : freq) {
            counts.push_back(p.second);
        }

        sort(counts.begin(), counts.end());

        int operations = 0;
        int target = counts.back();

        for (int i = counts.size() - 2; i >= 0; --i) {
            if (counts[i] == target) continue;
            if (counts[i] < target) return -1;
            operations += counts[i] - target;
            target = counts[i] - (counts[i] - target);
        }

        return operations;
    }
};
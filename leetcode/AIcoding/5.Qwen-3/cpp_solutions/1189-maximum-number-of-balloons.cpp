#include <iostream>
#include <vector>
#include <map>
#include <string>

using namespace std;

class Solution {
public:
    int maxNumberOfBalloons(string text) {
        map<char, int> count;
        for (char c : text) {
            count[c]++;
        }

        int minCount = INT_MAX;
        vector<char> required = {'b', 'a', 'l', 'o', 'n'};
        vector<int> requiredCounts = {1, 1, 2, 2, 1};

        for (int i = 0; i < required.size(); ++i) {
            char c = required[i];
            int needed = requiredCounts[i];
            if (count.find(c) == count.end()) {
                return 0;
            }
            minCount = min(minCount, count[c] / needed);
        }

        return minCount;
    }
};
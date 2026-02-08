#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestWellPerformingInterval(vector<int>& hours) {
        unordered_map<int, int> map;
        map[0] = -1;
        int maxLen = 0;
        int score = 0;
        for (int i = 0; i < hours.size(); ++i) {
            score += (hours[i] > 8 ? 1 : -1);
            if (map.find(score) != map.end()) {
                maxLen = max(maxLen, i - map[score]);
            } else {
                map[score] = i;
            }
        }
        return maxLen;
    }
};
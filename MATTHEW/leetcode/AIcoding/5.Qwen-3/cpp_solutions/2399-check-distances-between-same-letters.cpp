#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool checkDistances(string s, vector<int>& distance) {
        unordered_map<char, int> firstOccurrence;
        for (int i = 0; i < s.length(); ++i) {
            if (firstOccurrence.find(s[i]) == firstOccurrence.end()) {
                firstOccurrence[s[i]] = i;
            } else {
                int expectedDistance = distance[s[i] - 'a'];
                int actualDistance = i - firstOccurrence[s[i]] - 1;
                if (actualDistance != expectedDistance) {
                    return false;
                }
            }
        }
        return true;
    }
};
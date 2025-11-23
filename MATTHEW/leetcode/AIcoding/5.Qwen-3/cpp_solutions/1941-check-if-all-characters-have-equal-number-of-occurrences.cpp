#include <iostream>
#include <vector>
#include <map>
#include <set>

using namespace std;

class Solution {
public:
    bool areOccurrencesEqual(string s) {
        map<char, int> count;
        for (char c : s) {
            count[c]++;
        }
        set<int> occurrences;
        for (auto& pair : count) {
            occurrences.insert(pair.second);
        }
        return occurrences.size() == 1;
    }
};
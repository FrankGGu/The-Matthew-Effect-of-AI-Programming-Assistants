#include <unordered_map>
#include <string>
#include <set>

using namespace std;

class Solution {
public:
    bool areOccurrencesEqual(string s) {
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }
        set<int> counts;
        for (auto& pair : freq) {
            counts.insert(pair.second);
        }
        return counts.size() == 1;
    }
};
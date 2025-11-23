#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool areOccurrencesEqual(string s) {
        unordered_map<char, int> counts;
        for (char c : s) {
            counts[c]++;
        }

        int firstCount = -1;
        for (auto const& [key, val] : counts) {
            if (firstCount == -1) {
                firstCount = val;
            } else if (val != firstCount) {
                return false;
            }
        }

        return true;
    }
};
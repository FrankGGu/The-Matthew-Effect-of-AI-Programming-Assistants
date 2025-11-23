#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool canConstruct(string s, int k) {
        if (k > s.length()) {
            return false;
        }

        unordered_map<char, int> counts;
        for (char c : s) {
            counts[c]++;
        }

        int oddCount = 0;
        for (auto const& [key, val] : counts) {
            if (val % 2 != 0) {
                oddCount++;
            }
        }

        return oddCount <= k;
    }
};
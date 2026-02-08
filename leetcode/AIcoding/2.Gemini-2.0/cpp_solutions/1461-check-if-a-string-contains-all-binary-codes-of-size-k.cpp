#include <string>
#include <unordered_set>
#include <cmath>

using namespace std;

class Solution {
public:
    bool hasAllCodes(string s, int k) {
        if (s.length() < k) return false;

        unordered_set<string> seen;
        for (int i = 0; i <= s.length() - k; ++i) {
            seen.insert(s.substr(i, k));
        }

        return seen.size() == pow(2, k);
    }
};
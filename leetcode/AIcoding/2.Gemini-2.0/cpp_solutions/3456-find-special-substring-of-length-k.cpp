#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findSpecialSubstring(int n, string s, int k) {
        int count = 0;
        for (int i = 0; i <= n - k; ++i) {
            unordered_map<char, int> charCount;
            bool special = true;
            for (int j = i; j < i + k; ++j) {
                charCount[s[j]]++;
            }
            for (auto const& [key, val] : charCount) {
                if (val > 1) {
                    special = false;
                    break;
                }
            }
            if (special) {
                count++;
            }
        }
        return count;
    }
};
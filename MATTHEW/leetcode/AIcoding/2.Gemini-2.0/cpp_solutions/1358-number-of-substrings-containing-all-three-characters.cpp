#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfSubstrings(string s) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            unordered_map<char, int> char_counts;
            for (int j = i; j < n; ++j) {
                char_counts[s[j]]++;
                if (char_counts['a'] > 0 && char_counts['b'] > 0 && char_counts['c'] > 0) {
                    count += (n - j);
                    break;
                }
            }
        }
        return count;
    }
};
#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countBeautifulSubstrings(string s, int k) {
        int n = s.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j <= n; ++j) {
                string sub = s.substr(i, j - i);
                int vowels = 0;
                for (char c : sub) {
                    if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                        ++vowels;
                    }
                }
                if (vowels == k && (j - i) % 2 == 0) {
                    ++count;
                }
            }
        }
        return count;
    }
};
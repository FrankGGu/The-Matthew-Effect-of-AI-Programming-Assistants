#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countCompleteSubstrings(string s) {
        int result = 0;
        int n = s.length();
        for (int i = 0; i < n; ) {
            int j = i;
            while (j < n && (abs(s[j] - s[j - 1]) <= 1 || j == i)) {
                j++;
            }
            string sub = s.substr(i, j - i);
            result += count(sub);
            i = j;
        }
        return result;
    }

private:
    int count(string& s) {
        int result = 0;
        int n = s.length();
        unordered_map<char, int> freq;
        for (int left = 0; left < n; left++) {
            freq.clear();
            for (int right = left; right < n; right++) {
                freq[s[right]]++;
                if (freq.size() == 26) {
                    result++;
                }
            }
        }
        return result;
    }
};
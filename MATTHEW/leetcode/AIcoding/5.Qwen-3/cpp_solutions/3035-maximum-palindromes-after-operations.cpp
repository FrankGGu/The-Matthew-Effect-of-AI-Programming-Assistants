#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumPalindrome(string s) {
        map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        int pairs = 0;
        int single = 0;

        for (auto& [c, count] : freq) {
            pairs += count / 2;
            if (count % 2 == 1) {
                single = 1;
            }
        }

        if (pairs == 0) {
            return 1;
        }

        int result = 2 * pairs + single;
        return result;
    }
};
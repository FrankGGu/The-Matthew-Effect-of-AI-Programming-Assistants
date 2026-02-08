#include <iostream>
#include <string>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    string makeSmallestPalindrome(string s) {
        map<char, int> counts;
        for (char c : s) {
            counts[c]++;
        }

        int oddCount = 0;
        char oddChar = 0;
        for (auto const& [key, val] : counts) {
            if (val % 2 != 0) {
                oddCount++;
                oddChar = key;
            }
        }

        if (oddCount > 1) {
            return "";
        }

        string firstHalf = "";
        for (auto const& [key, val] : counts) {
            firstHalf += string(val / 2, key);
        }

        string secondHalf = firstHalf;
        reverse(secondHalf.begin(), secondHalf.end());

        if (oddCount == 1) {
            return firstHalf + oddChar + secondHalf;
        } else {
            return firstHalf + secondHalf;
        }
    }
};
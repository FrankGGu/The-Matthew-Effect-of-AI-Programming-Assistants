#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string canConvertString(int k, string s1, string s2) {
        if (s1.length() != s2.length()) {
            return "No";
        }

        unordered_map<char, int> count;

        for (int i = 0; i < s1.length(); ++i) {
            char c1 = s1[i];
            char c2 = s2[i];

            if (c1 == c2) {
                continue;
            }

            int diff = (c2 - c1 + 26) % 26;

            if (diff > k) {
                return "No";
            }

            count[c1]++;
            if (count[c1] > k) {
                return "No";
            }
        }

        return "Yes";
    }
};
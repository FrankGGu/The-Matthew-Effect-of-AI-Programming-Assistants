#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numGoodPairs(string s) {
        vector<int> count(26, 0);
        int result = 0;
        for (char c : s) {
            count[c - 'a']++;
        }
        for (int i = 0; i < 26; i++) {
            if (count[i] >= 2) {
                result += count[i] * (count[i] - 1) / 2;
            }
        }
        return result;
    }
};
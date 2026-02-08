#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countConsistentStrings(string allowed, vector<string>& words) {
        bool allowedSet[26] = {false};
        for (char c : allowed) {
            allowedSet[c - 'a'] = true;
        }
        int count = 0;
        for (string word : words) {
            bool valid = true;
            for (char c : word) {
                if (!allowedSet[c - 'a']) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                count++;
            }
        }
        return count;
    }
};
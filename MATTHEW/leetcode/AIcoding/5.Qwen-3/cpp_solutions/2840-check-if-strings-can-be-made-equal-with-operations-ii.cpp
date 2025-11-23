#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool checkIfEqual(string s1, string s2) {
        if (s1.length() != s2.length()) return false;

        unordered_map<char, int> count1;
        unordered_map<char, int> count2;

        for (char c : s1) {
            count1[c]++;
        }

        for (char c : s2) {
            count2[c]++;
        }

        return count1 == count2;
    }
};
#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string truncateSentence(string s, int k) {
        string result;
        int count = 0;
        for (char c : s) {
            if (count == k) break;
            result += c;
            if (c == ' ') count++;
        }
        return result;
    }
};
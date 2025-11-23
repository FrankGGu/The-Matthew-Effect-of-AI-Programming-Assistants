#include <iostream>
#include <string>
#include <map>

using namespace std;

class Solution {
public:
    int percentageLetter(string s, char c) {
        map<char, int> count;
        for (char ch : s) {
            count[ch]++;
        }
        int total = s.length();
        int freq = count[c];
        return (freq * 100) / total;
    }
};
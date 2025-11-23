#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numRunes(const string& s) {
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }
        int maxFreq = 0;
        char mostFrequent = 'a';
        for (auto& [c, count] : freq) {
            if (count > maxFreq) {
                maxFreq = count;
                mostFrequent = c;
            }
        }
        int result = 0;
        for (auto& [c, count] : freq) {
            if (count == maxFreq && c != mostFrequent) {
                result++;
            }
        }
        return result;
    }
};
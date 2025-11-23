#include <iostream>
#include <vector>
#include <unordered_map>
#include <string>

using namespace std;

class Solution {
public:
    long long minimumOperationsToMakeKPeriodic(string word, long long k) {
        unordered_map<string, long long> freq;
        int n = word.size();
        for (int i = 0; i < n; i += k) {
            string sub = word.substr(i, k);
            freq[sub]++;
        }
        long long maxFreq = 0;
        for (auto& [key, value] : freq) {
            if (value > maxFreq) {
                maxFreq = value;
            }
        }
        return (n / k) - maxFreq;
    }
};
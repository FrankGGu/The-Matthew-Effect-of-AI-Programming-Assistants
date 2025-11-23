#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int sumOfBeauty(string s) {
        int n = s.size();
        int result = 0;
        for (int i = 0; i < n; ++i) {
            unordered_map<char, int> freq;
            int maxFreq = 0;
            for (int j = i; j < n; ++j) {
                freq[s[j]]++;
                maxFreq = max(maxFreq, freq[s[j]]);
                if (maxFreq == 1) {
                    result += 1;
                } else {
                    result += maxFreq;
                }
            }
        }
        return result;
    }
};
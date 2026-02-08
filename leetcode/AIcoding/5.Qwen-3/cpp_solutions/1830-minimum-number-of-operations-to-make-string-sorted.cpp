#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperationsToMakeStringSorted(const string& s) {
        int n = s.size();
        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        long long result = 0;
        long long factorial[26];
        factorial[0] = 1;
        for (int i = 1; i < 26; ++i) {
            factorial[i] = factorial[i - 1] * i;
        }

        for (int i = 0; i < n; ++i) {
            int count = 0;
            for (int j = 0; j < s[i] - 'a'; ++j) {
                if (freq[j] > 0) {
                    count++;
                }
            }

            long long temp = 1;
            for (int j = 0; j < 26; ++j) {
                if (freq[j] > 0) {
                    temp *= factorial[freq[j]];
                }
            }

            result += (count * factorial[n - i - 1]) / temp;

            freq[s[i] - 'a']--;
        }

        return result;
    }
};
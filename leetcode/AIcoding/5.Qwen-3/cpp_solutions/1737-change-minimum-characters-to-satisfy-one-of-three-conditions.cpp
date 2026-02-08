#include <iostream>
#include <vector>
#include <string>
#include <map>

using namespace std;

class Solution {
public:
    int minChanges(string a, string b, string c) {
        map<char, int> countA;
        map<char, int> countB;
        map<char, int> countC;

        for (char ch : a) countA[ch]++;
        for (char ch : b) countB[ch]++;
        for (char ch : c) countC[ch]++;

        int res = 0;

        for (char ch = 'a'; ch <= 'z'; ch++) {
            int total = countA[ch] + countB[ch] + countC[ch];
            if (total == 0) continue;
            int maxCount = max({countA[ch], countB[ch], countC[ch]});
            res += (total - maxCount);
        }

        return res;
    }
};
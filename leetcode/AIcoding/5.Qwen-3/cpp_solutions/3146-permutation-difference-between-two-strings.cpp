#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int permutationDifference(string s, string t) {
        vector<int> posS(26, 0);
        vector<int> posT(26, 0);

        for (int i = 0; i < s.length(); ++i) {
            posS[s[i] - 'a'] = i;
        }

        for (int i = 0; i < t.length(); ++i) {
            posT[t[i] - 'a'] = i;
        }

        int result = 0;
        for (int i = 0; i < 26; ++i) {
            result += abs(posS[i] - posT[i]);
        }

        return result;
    }
};
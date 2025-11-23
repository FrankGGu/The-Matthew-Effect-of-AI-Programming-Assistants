#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCharacters(string a, string b) {
        int n = a.length();
        int m = b.length();

        vector<int> freqA(26, 0);
        for (char c : a) {
            freqA[c - 'a']++;
        }

        vector<int> freqB(26, 0);
        for (char c : b) {
            freqB[c - 'a']++;
        }

        int res = n + m;

        // Condition 3: Make both strings monochromatic with the same character
        for (int i = 0; i < 26; ++i) {
            res = min(res, (n - freqA[i]) + (m - freqB[i]));
        }

        // Conditions 1 and 2
        int leftA = 0;
        int rightA = n;
        int leftB = 0;
        int rightB = m;

        for (int i = 0; i < 25; ++i) {
            leftA += freqA[i];
            rightA -= freqA[i];
            leftB += freqB[i];
            rightB -= freqB[i];

            // Condition 1: a < char('a'+i+1), b >= char('a'+i+1)
            res = min(res, rightA + leftB);

            // Condition 2: b < char('a'+i+1), a >= char('a'+i+1)
            res = min(res, rightB + leftA);
        }

        return res;
    }
};
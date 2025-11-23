#include <string>
#include <algorithm>
#include <vector>

using namespace std;

class Solution {
public:
    int minCharacters(string a, string b) {
        int n = a.length();
        int m = b.length();
        vector<int> countA(26, 0);
        vector<int> countB(26, 0);

        for (char c : a) {
            countA[c - 'a']++;
        }
        for (char c : b) {
            countB[c - 'a']++;
        }

        int ans = n + m;
        for (int i = 0; i < 26; i++) {
            ans = min(ans, n + m - countA[i] - countB[i]);
        }

        for (int i = 0; i < 25; i++) {
            int tempA = 0;
            int tempB = 0;
            for (int j = i + 1; j < 26; j++) {
                tempA += countA[j];
            }
            for (int j = 0; j <= i; j++) {
                tempB += countB[j];
            }
            ans = min(ans, tempA + tempB);

            tempA = 0;
            tempB = 0;
            for (int j = i + 1; j < 26; j++) {
                tempB += countB[j];
            }
            for (int j = 0; j <= i; j++) {
                tempA += countA[j];
            }
            ans = min(ans, tempA + tempB);
        }

        return ans;
    }
};
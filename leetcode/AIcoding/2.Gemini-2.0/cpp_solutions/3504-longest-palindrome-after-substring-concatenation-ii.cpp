#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestPalindrome(vector<string>& words) {
        int count[26][26] = {0};
        int ans = 0;
        bool central = false;

        for (string& word : words) {
            int a = word[0] - 'a';
            int b = word[1] - 'a';

            if (count[b][a] > 0) {
                ans += 4;
                count[b][a]--;
            } else {
                count[a][b]++;
            }
        }

        for (int i = 0; i < 26; ++i) {
            if (count[i][i] > 0) {
                central = true;
                break;
            }
        }

        if (central) {
            ans += 2;
        }

        return ans;
    }
};
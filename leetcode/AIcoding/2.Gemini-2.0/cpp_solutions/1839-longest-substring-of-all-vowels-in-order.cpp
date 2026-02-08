#include <string>

using namespace std;

class Solution {
public:
    int longestBeautifulSubstring(string word) {
        int n = word.length();
        int ans = 0;
        for (int i = 0; i < n;) {
            int j = i;
            int vowels = 1;
            while (j + 1 < n && word[j + 1] >= word[j]) {
                if (word[j + 1] > word[j]) {
                    vowels++;
                }
                j++;
            }

            if (vowels == 5) {
                ans = max(ans, j - i + 1);
            }
            i = j + 1;
        }
        return ans;
    }
};
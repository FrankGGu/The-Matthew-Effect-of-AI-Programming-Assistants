#include <string>

using namespace std;

class Solution {
public:
    int addMinimum(string word) {
        int n = word.length();
        int ans = 0;
        for (int i = 0; i < n;) {
            if (i < n && word[i] == 'a') {
                i++;
            } else {
                ans++;
            }
            if (i < n && word[i] == 'b') {
                i++;
            } else {
                ans++;
            }
            if (i < n && word[i] == 'c') {
                i++;
            } else {
                ans++;
            }
        }
        return ans;
    }
};
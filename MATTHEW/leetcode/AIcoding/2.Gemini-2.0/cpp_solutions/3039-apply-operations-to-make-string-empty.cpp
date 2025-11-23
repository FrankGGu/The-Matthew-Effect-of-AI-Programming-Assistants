#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string applyOperations(string s) {
        int n = s.size();
        vector<bool> removed(n, false);
        string t = s;
        int k = 0;
        while (k < n) {
            int i = k;
            while (i < n && removed[i]) {
                i++;
            }
            if (i == n) {
                break;
            }
            int j = i + 1;
            while (j < n && removed[j]) {
                j++;
            }
            if (j == n) {
                break;
            }

            if (s[i] == s[j]) {
                s[i]++;
                if (s[i] > 'z') {
                    s[i] = 'a';
                }
                removed[j] = true;
            } else {
                s[i]--;
                if (s[i] < 'a') {
                    s[i] = 'z';
                }
                removed[i] = true;
            }
            k = j + 1;
        }

        string ans = "";
        for (int i = 0; i < n; i++) {
            if (!removed[i]) {
                ans += s[i];
            }
        }
        return ans;
    }
};
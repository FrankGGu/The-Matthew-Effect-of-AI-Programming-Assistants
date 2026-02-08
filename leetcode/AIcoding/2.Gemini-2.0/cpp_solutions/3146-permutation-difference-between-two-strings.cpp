#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int permutationDifference(string s, string t) {
        int n = s.size();
        int m = t.size();
        if (n != m) {
            return -1;
        }

        string sortedS = s;
        sort(sortedS.begin(), sortedS.end());

        int minDiff = -1;
        string temp = t;
        sort(temp.begin(),temp.end());

        if(sortedS != temp){
            return -1;
        }

        vector<int> p(n);
        for (int i = 0; i < n; ++i) {
            p[i] = i;
        }

        do {
            string permutedS = "";
            for (int i = 0; i < n; ++i) {
                permutedS += s[p[i]];
            }

            int diff = 0;
            for (int i = 0; i < n; ++i) {
                if (permutedS[i] != t[i]) {
                    diff++;
                }
            }

            if (minDiff == -1 || diff < minDiff) {
                minDiff = diff;
            }
        } while (next_permutation(p.begin(), p.end()));

        return minDiff;
    }
};
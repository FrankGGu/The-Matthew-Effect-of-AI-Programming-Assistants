#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool checkIfCanBreak(string s1, string s2) {
        sort(s1.begin(), s1.end());
        sort(s2.begin(), s2.end());

        bool break1 = true;
        bool break2 = true;

        for (int i = 0; i < s1.length(); ++i) {
            if (s1[i] < s2[i]) {
                break1 = false;
            }
            if (s2[i] < s1[i]) {
                break2 = false;
            }
        }

        return break1 || break2;
    }
};
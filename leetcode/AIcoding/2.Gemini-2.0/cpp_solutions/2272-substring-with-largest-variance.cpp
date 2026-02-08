#include <string>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int largestVariance(string s) {
        int n = s.length();
        int ans = 0;
        for (char a = 'a'; a <= 'z'; ++a) {
            for (char b = 'a'; b <= 'z'; ++b) {
                if (a == b) continue;
                int maxSoFar = 0;
                int maxEndingHere = 0;
                bool hasA = false;
                for (char c : s) {
                    if (c == a) {
                        maxEndingHere++;
                        hasA = true;
                    } else if (c == b) {
                        maxEndingHere--;
                    }
                    maxSoFar = max(maxSoFar, maxEndingHere);
                    if (maxEndingHere < 0) {
                        maxEndingHere = 0;
                    }
                }
                if (!hasA) continue;

                maxEndingHere = 0;
                int minSoFar = 0;
                bool hasB = false;
                for (int i = 0; i < n; ++i) {
                    char c = s[i];
                    if (c == b) {
                        maxEndingHere++;
                        hasB = true;
                    } else if (c == a) {
                        maxEndingHere--;
                    }
                    minSoFar = max(minSoFar, maxEndingHere);
                    if (maxEndingHere < 0) {
                        maxEndingHere = 0;
                    }
                }
                if (!hasB) continue;

                maxSoFar = 0;
                maxEndingHere = 0;
                hasA = false;
                bool hasBInside = false;
                for (char c : s) {
                    if (c == a) {
                        maxEndingHere++;
                        hasA = true;
                    } else if (c == b) {
                        maxEndingHere--;
                        hasBInside = true;
                    }
                    if (hasA && hasBInside) {
                        ans = max(ans, maxEndingHere);
                    }
                    if (maxEndingHere < 0) {
                        maxEndingHere = 0;
                        hasBInside = false;
                    }
                }
            }
        }
        return ans;
    }
};
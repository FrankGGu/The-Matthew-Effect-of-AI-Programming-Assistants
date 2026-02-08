#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int smallestSubstring(string s) {
        int n = s.length();
        int minLen = -1;

        for (char c : {'a', 'b', 'c'}) {
            int first = -1, last = -1;
            for (int i = 0; i < n; ++i) {
                if (s[i] == c) {
                    if (first == -1) {
                        first = i;
                    }
                    last = i;
                }
            }

            if (first != -1) {
                for (char c2 : {'a', 'b', 'c'}) {
                    if (c2 == c) continue;
                    int first2 = -1, last2 = -1;
                    for (int i = 0; i < n; ++i) {
                        if (s[i] == c2) {
                            if (first2 == -1) {
                                first2 = i;
                            }
                            last2 = i;
                        }
                    }

                    if (first2 != -1) {
                        for (char c3 : {'a', 'b', 'c'}) {
                            if (c3 == c || c3 == c2) continue;
                            int first3 = -1, last3 = -1;
                            for (int i = 0; i < n; ++i) {
                                if (s[i] == c3) {
                                    if (first3 == -1) {
                                        first3 = i;
                                    }
                                    last3 = i;
                                }
                            }

                            if (first3 != -1) {
                                int start = min({first, first2, first3});
                                int end = max({last, last2, last3});
                                int len = end - start + 1;
                                if (minLen == -1 || len < minLen) {
                                    minLen = len;
                                }
                            }
                        }
                    }
                }
            }
        }

        return minLen;
    }
};
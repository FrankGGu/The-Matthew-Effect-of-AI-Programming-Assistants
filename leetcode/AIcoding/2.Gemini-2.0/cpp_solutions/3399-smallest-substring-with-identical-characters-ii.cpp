#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int smallestSubstring(string s) {
        int n = s.length();
        int minLen = -1;

        for (int k = 1; k <= 26; ++k) {
            for (int i = 0; i < n; ++i) {
                for (int j = i; j < n; ++j) {
                    unordered_map<char, int> counts;
                    for (int l = i; l <= j; ++l) {
                        counts[s[l]]++;
                    }

                    int distinctChars = 0;
                    for (auto const& [key, val] : counts) {
                        if (val > 0) {
                            distinctChars++;
                        }
                    }

                    if (distinctChars == k) {
                        bool allEqual = true;
                        int firstCount = -1;
                        for (auto const& [key, val] : counts) {
                            if (val > 0) {
                                if (firstCount == -1) {
                                    firstCount = val;
                                } else if (val != firstCount) {
                                    allEqual = false;
                                    break;
                                }
                            }
                        }

                        if (allEqual) {
                            int len = j - i + 1;
                            if (minLen == -1 || len < minLen) {
                                minLen = len;
                            }
                        }
                    }
                }
            }
        }

        return minLen;
    }
};
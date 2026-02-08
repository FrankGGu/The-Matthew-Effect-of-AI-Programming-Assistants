#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestDecomposition(string text) {
        int n = text.size();
        if (n == 0) return 0;
        for (int i = 0; i < n / 2; ++i) {
            if (text.substr(0, i + 1) == text.substr(n - i - 1, i + 1)) {
                return 2 + longestDecomposition(text.substr(i + 1, n - 2 * (i + 1)));
            }
        }
        return 1;
    }
};
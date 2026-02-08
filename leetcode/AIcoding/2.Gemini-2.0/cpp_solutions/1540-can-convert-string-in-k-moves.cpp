#include <string>
#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    bool canConvertString(string s, string t, int k) {
        if (s.length() != t.length()) {
            return false;
        }

        int n = s.length();
        vector<int> counts(26, 0);
        for (int i = 0; i < n; ++i) {
            int diff = (t[i] - s[i] + 26) % 26;
            if (diff != 0) {
                counts[diff]++;
            }
        }

        int max_moves = 0;
        for (int i = 1; i < 26; ++i) {
            max_moves = max(max_moves, (counts[i] - 1) * 26 + i);
        }

        for (int i = 0; i < n; ++i) {
            int diff = (t[i] - s[i] + 26) % 26;
            if (diff != 0) {
                if (diff + counts[diff] * 26 - diff > k) return false;
            }
        }

        for (int i = 1; i < 26; ++i) {
            if((counts[i]-1) * 26 + i > k) return false;
        }

        return true;

    }
};
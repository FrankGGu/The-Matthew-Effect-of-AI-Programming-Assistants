#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int uniqueLetterString(string s) {
        int n = s.length();
        vector<int> left(n, -1);
        vector<int> right(n, n);
        vector<int> last_pos(26, -1);

        for (int i = 0; i < n; ++i) {
            int c = s[i] - 'A';
            left[i] = last_pos[c];
            last_pos[c] = i;
        }

        last_pos.assign(26, n);
        for (int i = n - 1; i >= 0; --i) {
            int c = s[i] - 'A';
            right[i] = last_pos[c];
            last_pos[c] = i;
        }

        long long ans = 0;
        for (int i = 0; i < n; ++i) {
            ans = (ans + (long long)(i - left[i]) * (right[i] - i)) % 1000000007;
        }

        return (int)ans;
    }
};
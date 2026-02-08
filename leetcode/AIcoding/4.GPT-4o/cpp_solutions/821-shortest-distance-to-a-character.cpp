#include <vector>
#include <string>
#include <cmath>
using namespace std;

vector<int> shortestToChar(string s, char c) {
    int n = s.size();
    vector<int> ans(n);
    int prev = -1;

    for (int i = 0; i < n; ++i) {
        if (s[i] == c) {
            prev = i;
        }
        ans[i] = (prev == -1) ? INT_MAX : i - prev;
    }

    prev = -1;
    for (int i = n - 1; i >= 0; --i) {
        if (s[i] == c) {
            prev = i;
        }
        if (prev != -1) {
            ans[i] = min(ans[i], prev - i);
        }
    }

    return ans;
}
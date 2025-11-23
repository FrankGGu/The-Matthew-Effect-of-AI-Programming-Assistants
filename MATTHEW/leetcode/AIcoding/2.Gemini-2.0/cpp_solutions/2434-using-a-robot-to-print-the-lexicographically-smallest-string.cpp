#include <vector>
#include <string>
#include <algorithm>

using namespace std;

string robotWithString(string s) {
    int n = s.length();
    vector<int> min_suffix(n);
    min_suffix[n - 1] = s[n - 1];
    for (int i = n - 2; i >= 0; --i) {
        min_suffix[i] = min(min_suffix[i + 1], (int)s[i]);
    }

    string t = "";
    string p = "";
    for (int i = 0; i < n; ++i) {
        while (!p.empty() && p.back() <= min_suffix[i]) {
            t += p.back();
            p.pop_back();
        }
        p.push_back(s[i]);
    }

    while (!p.empty()) {
        t += p.back();
        p.pop_back();
    }

    return t;
}
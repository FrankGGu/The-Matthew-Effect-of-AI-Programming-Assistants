#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumGain(string s, int x, int y) {
        int ans = 0;
        string t = "";

        if (x > y) {
            string a = "ab", b = "ba";
            int p = x, q = y;
            for (char c : s) {
                t += c;
                while (t.size() >= 2 && t.substr(t.size() - 2) == a) {
                    t.resize(t.size() - 2);
                    ans += p;
                }
            }
            s = t;
            t = "";
            for (char c : s) {
                t += c;
                while (t.size() >= 2 && t.substr(t.size() - 2) == b) {
                    t.resize(t.size() - 2);
                    ans += q;
                }
            }
        } else {
            string a = "ba", b = "ab";
            int p = y, q = x;
            for (char c : s) {
                t += c;
                while (t.size() >= 2 && t.substr(t.size() - 2) == a) {
                    t.resize(t.size() - 2);
                    ans += p;
                }
            }
            s = t;
            t = "";
            for (char c : s) {
                t += c;
                while (t.size() >= 2 && t.substr(t.size() - 2) == b) {
                    t.resize(t.size() - 2);
                    ans += q;
                }
            }
        }

        return ans;
    }
};
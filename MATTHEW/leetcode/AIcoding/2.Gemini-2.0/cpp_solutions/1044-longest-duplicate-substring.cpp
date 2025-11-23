#include <string>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    string longestDupSubstring(string s) {
        int n = s.length();
        int low = 1, high = n;
        string result = "";

        while (low <= high) {
            int mid = low + (high - low) / 2;
            string dup = findDuplicate(s, mid);
            if (dup.empty()) {
                high = mid - 1;
            } else {
                result = dup;
                low = mid + 1;
            }
        }

        return result;
    }

private:
    string findDuplicate(string s, int len) {
        int n = s.length();
        if (len == 0) return "";

        long long h = 0;
        long long pow = 1;
        int a = 26;
        long long mod = 1000000007;

        for (int i = 0; i < len - 1; i++) {
            pow = (pow * a) % mod;
        }

        unordered_set<long long> seen;

        for (int i = 0; i < len; i++) {
            h = (h * a + (s[i] - 'a')) % mod;
        }

        seen.insert(h);

        for (int i = 1; i <= n - len; i++) {
            h = (h - (long long)(s[i - 1] - 'a') * pow % mod + mod) % mod;
            h = (h * a + (s[i + len - 1] - 'a')) % mod;

            if (seen.count(h)) {
                return s.substr(i, len);
            }
            seen.insert(h);
        }

        return "";
    }
};
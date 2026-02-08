#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minAnagramLength(string s) {
        int n = s.size();
        for (int len = 1; len <= n; ++len) {
            if (n % len != 0) continue;
            bool valid = true;
            unordered_map<string, int> freq;
            string first = s.substr(0, len);
            sort(first.begin(), first.end());
            freq[first]++;
            for (int i = len; i < n; i += len) {
                string current = s.substr(i, len);
                sort(current.begin(), current.end());
                if (current != first) {
                    valid = false;
                    break;
                }
            }
            if (valid) return len;
        }
        return n;
    }
};
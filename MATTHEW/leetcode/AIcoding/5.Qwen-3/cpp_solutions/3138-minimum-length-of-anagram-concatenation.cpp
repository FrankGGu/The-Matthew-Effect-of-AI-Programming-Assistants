#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minAnagramLength(vector<char>& s) {
        int n = s.size();
        for (int len = 1; len <= n; ++len) {
            if (n % len != 0) continue;
            bool valid = true;
            unordered_map<char, int> count;
            for (int i = 0; i < len; ++i) {
                count[s[i]]++;
            }
            for (int i = len; i < n; i += len) {
                unordered_map<char, int> temp;
                for (int j = 0; j < len; ++j) {
                    temp[s[i + j]]++;
                }
                if (temp != count) {
                    valid = false;
                    break;
                }
            }
            if (valid) return len;
        }
        return n;
    }
};
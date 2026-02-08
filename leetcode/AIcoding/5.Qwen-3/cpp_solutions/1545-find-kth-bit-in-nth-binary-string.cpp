#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    char findKthBit(int n, int k) {
        string s = "0";
        for (int i = 1; i < n; ++i) {
            string rev = s;
            reverse(rev.begin(), rev.end());
            for (char& c : rev) {
                c = (c == '0') ? '1' : '0';
            }
            s += '1' + rev;
        }
        return s[k - 1];
    }
};
#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int countHomogenous(string s) {
        long long count = 0;
        int n = s.length();
        for (int i = 0; i < n; ) {
            char c = s[i];
            int j = i;
            while (j < n && s[j] == c) {
                j++;
            }
            long long len = j - i;
            count += len * (len + 1) / 2;
            i = j;
        }
        return static_cast<int>(count);
    }
};
#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string findEncryptedWord(string s) {
        int n = s.size();
        vector<char> result(n);
        for (int i = 0; i < n; ++i) {
            int mid = i;
            if (i % 2 == 0) {
                mid = i / 2;
            } else {
                mid = (n - 1 - i) / 2;
            }
            result[mid] = s[i];
        }
        return string(result.begin(), result.end());
    }
};
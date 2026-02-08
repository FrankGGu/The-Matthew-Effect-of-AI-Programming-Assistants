#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countSpecialSubsequences(string s) {
        long long a = 0, ab = 0, abc = 0;
        for (char c : s) {
            if (c == 'a') {
                a = (a + 1) % 1000000007;
            } else if (c == 'b') {
                ab = (ab + a) % 1000000007;
            } else if (c == 'c') {
                abc = (abc + ab) % 1000000007;
            }
        }
        return static_cast<int>(abc);
    }
};
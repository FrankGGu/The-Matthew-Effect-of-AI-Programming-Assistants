#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    long long maximumSubsequenceCount(string s) {
        long long count = 0;
        long long a = 0, b = 0;
        for (char c : s) {
            if (c == 'a') {
                a++;
            } else if (c == 'b') {
                b++;
            }
        }
        count += max(a, b);
        return count;
    }
};
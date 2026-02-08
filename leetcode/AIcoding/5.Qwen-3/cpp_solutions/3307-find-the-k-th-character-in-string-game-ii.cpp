#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    char kthCharacter(string s, long long k) {
        long long n = s.length();
        long long index = 0;
        while (index < k) {
            long long nextIndex = index + 1;
            for (long long i = 0; i < n; ++i) {
                if (nextIndex > k) break;
                if (s[i] == 'a') {
                    nextIndex += nextIndex - index;
                } else {
                    nextIndex += nextIndex - index;
                }
            }
            index = nextIndex;
        }
        return s[k - 1];
    }
};
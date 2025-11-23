#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int numberOfUniqueGoodSubsequences(string s) {
        const int MOD = 1e9 + 7;
        int endsWithZero = 0;
        int endsWithOne = 0;

        for (char c : s) {
            if (c == '0') {
                endsWithZero = (endsWithZero + endsWithOne) % MOD;
            } else {
                endsWithOne = (endsWithZero + endsWithOne + 1) % MOD;
            }
        }

        bool hasZero = false;
        for (char c : s) {
            if (c == '0') {
                hasZero = true;
                break;
            }
        }

        int result = (endsWithZero + endsWithOne) % MOD;
        if (hasZero) {
            result = (result + 1) % MOD;
        }

        return result;
    }
};
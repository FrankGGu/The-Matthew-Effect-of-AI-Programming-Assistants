#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfWays(string s) {
        int n = s.length();
        vector<int> leftZero(n, 0), leftOne(n, 0);
        vector<int> rightZero(n, 0), rightOne(n, 0);

        for (int i = 1; i < n; ++i) {
            leftZero[i] = leftZero[i - 1] + (s[i - 1] == '0' ? 1 : 0);
            leftOne[i] = leftOne[i - 1] + (s[i - 1] == '1' ? 1 : 0);
        }

        for (int i = n - 2; i >= 0; --i) {
            rightZero[i] = rightZero[i + 1] + (s[i + 1] == '0' ? 1 : 0);
            rightOne[i] = rightOne[i + 1] + (s[i + 1] == '1' ? 1 : 0);
        }

        int result = 0;
        for (int i = 1; i < n - 1; ++i) {
            if (s[i] == '0') {
                result += leftOne[i] * rightOne[i];
            } else {
                result += leftZero[i] * rightZero[i];
            }
        }

        return result;
    }
};
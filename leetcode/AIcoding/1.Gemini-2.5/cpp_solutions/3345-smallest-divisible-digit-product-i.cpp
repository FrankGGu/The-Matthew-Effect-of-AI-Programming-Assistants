#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int smallestNumber(int n) {
        if (n == 1) return 1;
        string s = "";
        for (int i = 9; i >= 2; --i) {
            while (n % i == 0) {
                s += to_string(i);
                n /= i;
            }
        }
        if (n != 1) return -1;
        reverse(s.begin(), s.end());
        return stoi(s);
    }
};
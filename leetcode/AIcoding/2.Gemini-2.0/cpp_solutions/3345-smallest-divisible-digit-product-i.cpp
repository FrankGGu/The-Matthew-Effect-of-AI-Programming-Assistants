#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int smallestNumber(int n) {
        if (n == 1) return 1;
        if (n == 0) return 10;

        string result = "";
        for (int i = 9; i >= 2; --i) {
            while (n % i == 0) {
                result += to_string(i);
                n /= i;
            }
        }

        if (n != 1) return -1;

        reverse(result.begin(), result.end());
        return stoi(result);
    }
};
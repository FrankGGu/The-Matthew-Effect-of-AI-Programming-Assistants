#include <string>

using namespace std;

class Solution {
public:
    int magicalString(int n) {
        if (n == 0) return 0;
        if (n <= 3) return 1;

        string s = "122";
        int head = 2, tail = 3, oneCount = 1;

        while (tail < n) {
            int num = s[head] - '0';
            int val = (s[tail - 1] == '1') ? 2 : 1;

            for (int i = 0; i < num && tail < n; ++i) {
                s += (val + '0');
                if (val == 1) oneCount++;
                tail++;
            }
            head++;
        }

        return oneCount;
    }
};
#include <string>
#include <algorithm>
#include <vector>

using namespace std;

class Solution {
public:
    int minOperations(int num1, int num2) {
        string s1 = to_string(num1);
        string s2 = to_string(num2);

        int n1 = s1.length();
        int n2 = s2.length();

        if (n1 > n2) {
            return -1;
        }

        if (n1 < n2) {
            return -1;
        }

        if (num1 == num2) {
            return 0;
        }

        int ans = 0;
        for (int i = 0; i < n1; ++i) {
            if (s1[i] != s2[i]) {
                ans++;
            }
        }

        return ans;
    }
};
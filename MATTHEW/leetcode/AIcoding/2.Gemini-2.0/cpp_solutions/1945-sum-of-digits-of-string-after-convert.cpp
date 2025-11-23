#include <string>
#include <numeric>

using namespace std;

class Solution {
public:
    int getLucky(string s, int k) {
        string converted = "";
        for (char c : s) {
            converted += to_string(c - 'a' + 1);
        }

        int sum = 0;
        for (int i = 0; i < k; ++i) {
            sum = 0;
            for (char c : converted) {
                sum += c - '0';
            }
            converted = to_string(sum);
        }

        return sum;
    }
};
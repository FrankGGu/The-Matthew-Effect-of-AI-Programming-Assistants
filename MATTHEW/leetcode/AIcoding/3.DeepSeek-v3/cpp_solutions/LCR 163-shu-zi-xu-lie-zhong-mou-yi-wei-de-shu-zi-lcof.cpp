#include <string>
using namespace std;

class Solution {
public:
    int findKthNumber(int n, int k) {
        long long len = 1;
        long long count = 9;
        long long start = 1;
        long long kLong = k;

        while (kLong > len * count) {
            kLong -= len * count;
            len++;
            count *= 10;
            start *= 10;
        }

        long long num = start + (kLong - 1) / len;
        int pos = (kLong - 1) % len;

        return to_string(num)[pos] - '0';
    }
};
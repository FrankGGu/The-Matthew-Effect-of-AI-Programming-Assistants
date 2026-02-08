#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int partitionString(string s, int k) {
        int count = 1;
        long long current_num = 0;
        for (char c : s) {
            int digit = c - 'a' + 1;
            if (digit > k) {
                return -1;
            }
            if (current_num * 10 + digit <= k) {
                current_num = current_num * 10 + digit;
            } else {
                count++;
                current_num = digit;
            }
        }
        return count;
    }
};
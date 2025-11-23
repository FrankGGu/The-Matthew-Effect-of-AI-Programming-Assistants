#include <string>

using namespace std;

class Solution {
public:
    int nextBeautifulNumber(int n) {
        while (true) {
            n++;
            string s = to_string(n);
            int counts[10] = {0};
            for (char c : s) {
                counts[c - '0']++;
            }
            bool balanced = true;
            for (int i = 0; i < 10; i++) {
                if (counts[i] != 0 && counts[i] != i) {
                    balanced = false;
                    break;
                }
            }
            if (balanced) {
                return n;
            }
        }
    }
};
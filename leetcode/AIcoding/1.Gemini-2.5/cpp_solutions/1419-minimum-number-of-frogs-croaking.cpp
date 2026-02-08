#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    int minNumberOfFrogs(std::string croakOfFrogs) {
        int c = 0;
        int r = 0;
        int o = 0;
        int a = 0;
        int k = 0;

        int max_frogs = 0;
        int current_active_frogs = 0;

        for (char ch : croakOfFrogs) {
            if (ch == 'c') {
                c++;
                current_active_frogs++;
                max_frogs = std::max(max_frogs, current_active_frogs);
            } else if (ch == 'r') {
                if (c == 0) return -1;
                r++;
                c--;
            } else if (ch == 'o') {
                if (r == 0) return -1;
                o++;
                r--;
            } else if (ch == 'a') {
                if (o == 0) return -1;
                a++;
                o--;
            } else if (ch == 'k') {
                if (a == 0) return -1;
                k++;
                a--;
                current_active_frogs--;
            }
        }

        if (c != 0 || r != 0 || o != 0 || a != 0) {
            return -1;
        }

        return max_frogs;
    }
};
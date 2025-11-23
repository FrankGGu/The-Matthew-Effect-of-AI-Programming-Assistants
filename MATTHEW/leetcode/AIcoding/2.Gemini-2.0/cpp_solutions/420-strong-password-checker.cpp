#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int strongPasswordChecker(string password) {
        int n = password.length();
        int missing = 0;
        if (!any_of(password.begin(), password.end(), ::isdigit)) missing++;
        if (!any_of(password.begin(), password.end(), ::islower)) missing++;
        if (!any_of(password.begin(), password.end(), ::isupper)) missing++;

        int changes = 0;
        if (n < 6) {
            changes = max(missing, 6 - n);
        } else if (n > 20) {
            changes = n - 20;
            int one = 0, two = 0, three = 0;
            for (int i = 0; i < n;) {
                int j = i;
                while (j < n && password[i] == password[j]) j++;
                int len = j - i;
                if (len >= 3) {
                    if (len % 3 == 0) one++;
                    else if (len % 3 == 1) two++;
                    else three++;
                }
                i = j;
            }

            int reduce = 0;
            for (int i = 1; i <= changes; i++) {
                if (one > 0) {
                    reduce++;
                    one--;
                } else if (two > 0) {
                    reduce += 2;
                    two--;
                } else {
                    reduce += 3;
                    three--;
                }
            }
            changes = n - 20 + max(missing, reduce / 3);
        } else {
            int repeat = 0;
            for (int i = 0; i < n;) {
                int j = i;
                while (j < n && password[i] == password[j]) j++;
                int len = j - i;
                if (len >= 3) {
                    repeat += len / 3;
                }
                i = j;
            }
            changes = max(missing, repeat);
        }

        return changes;
    }
};
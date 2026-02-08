#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int strongPasswordChecker(string password) {
        int n = password.size();
        int missing = 0;
        if (n < 6) return max(6 - n, missing);

        vector<int> repeat;
        int i = 0;
        while (i < n) {
            int j = i;
            while (j < n && password[j] == password[i]) j++;
            if (j - i >= 3) repeat.push_back(j - i);
            i = j;
        }

        int replace = 0;
        for (int r : repeat) {
            replace += r / 3;
        }

        if (n <= 20) {
            return max(6 - n, replace);
        } else {
            int remove = n - 20;
            int i = 0;
            while (remove > 0 && i < repeat.size()) {
                if (repeat[i] % 3 == 0) {
                    int use = min(remove, 1);
                    repeat[i] -= use;
                    remove -= use;
                }
                i++;
            }

            i = 0;
            while (remove > 0 && i < repeat.size()) {
                if (repeat[i] % 3 == 1) {
                    int use = min(remove, 2);
                    repeat[i] -= use;
                    remove -= use;
                }
                i++;
            }

            i = 0;
            while (remove > 0 && i < repeat.size()) {
                int use = min(remove, repeat[i] / 2);
                repeat[i] -= use;
                remove -= use;
                i++;
            }

            replace = 0;
            for (int r : repeat) {
                replace += r / 3;
            }

            return (n - 20) + replace;
        }
    }
};
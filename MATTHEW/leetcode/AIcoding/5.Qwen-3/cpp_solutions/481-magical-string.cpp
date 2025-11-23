#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int magicalString(int n) {
        if (n == 0) return 0;
        if (n <= 3) return 1;

        vector<int> s = {1, 2, 2};
        int i = 2, j = 2;
        while (j < n) {
            int next = s[i] == 1 ? 2 : 1;
            int count = s[i];
            for (int k = 0; k < count && j < n; ++k) {
                s.push_back(next);
                j++;
            }
            i++;
        }

        int result = 0;
        for (int k = 0; k < n; ++k) {
            if (s[k] == 1) result++;
        }
        return result;
    }
};
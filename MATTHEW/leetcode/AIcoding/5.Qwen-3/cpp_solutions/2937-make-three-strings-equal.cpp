#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperationsToEqualThreeStrings(string s1, string s2, string s3) {
        int n = s1.size();
        int operations = 0;

        for (int i = 0; i < n; ++i) {
            char c1 = s1[i];
            char c2 = s2[i];
            char c3 = s3[i];

            if (c1 != c2 || c1 != c3) {
                if (c1 == c2) {
                    operations += 1;
                } else if (c1 == c3) {
                    operations += 1;
                } else if (c2 == c3) {
                    operations += 1;
                } else {
                    operations += 2;
                }
            }
        }

        return operations;
    }
};
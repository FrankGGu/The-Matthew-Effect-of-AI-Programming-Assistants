#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numFriendRequests(string ages) {
        vector<int> count(121, 0);
        for (char c : ages) {
            count[c - '0']++;
        }

        int result = 0;
        for (int ageA = 0; ageA <= 120; ++ageA) {
            if (count[ageA] == 0) continue;
            for (int ageB = 0; ageB <= 120; ++ageB) {
                if (count[ageB] == 0) continue;
                if (ageB > ageA) continue;
                if (ageB <= 0.5 * ageA + 10) continue;
                if (ageB > ageA) continue;
                if (ageA == ageB) {
                    result += count[ageA] * (count[ageA] - 1);
                } else {
                    result += count[ageA] * count[ageB];
                }
            }
        }
        return result;
    }
};
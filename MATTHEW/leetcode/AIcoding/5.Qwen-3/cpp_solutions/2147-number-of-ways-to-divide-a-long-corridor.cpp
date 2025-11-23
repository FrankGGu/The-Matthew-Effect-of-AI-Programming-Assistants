#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfWays(string corridor) {
        vector<int> positions;
        for (int i = 0; i < corridor.length(); ++i) {
            if (corridor[i] == 'A') {
                positions.push_back(i);
            }
        }

        if (positions.size() % 2 != 0) {
            return 0;
        }

        int result = 1;
        for (int i = 2; i < positions.size(); i += 2) {
            int prev = positions[i - 1];
            int curr = positions[i];
            result = (result * (curr - prev)) % 1000000007;
        }

        return result;
    }
};
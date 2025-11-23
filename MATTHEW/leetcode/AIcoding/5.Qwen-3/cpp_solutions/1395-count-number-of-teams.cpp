#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numTeams(int num, vector<int>& rating) {
        int count = 0;
        for (int i = 0; i < num; ++i) {
            for (int j = i + 1; j < num; ++j) {
                for (int k = j + 1; k < num; ++k) {
                    if ((rating[i] < rating[j] && rating[j] < rating[k]) || (rating[i] > rating[j] && rating[j] > rating[k])) {
                        ++count;
                    }
                }
            }
        }
        return count;
    }
};
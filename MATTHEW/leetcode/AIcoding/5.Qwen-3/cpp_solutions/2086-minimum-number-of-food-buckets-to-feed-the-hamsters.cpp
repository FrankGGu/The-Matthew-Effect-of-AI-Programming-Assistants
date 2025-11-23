#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minFoodBuckets(string street, int k) {
        int n = street.length();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (street[i] == 'H') {
                if (i + 1 < n && street[i + 1] == 'H') {
                    count += 1;
                    i += 1;
                } else {
                    count += 1;
                }
            }
        }
        return count;
    }
};
#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int poorPigs(int totalBuckets, int timeToDie, int timeLimit) {
        int pigs = 0;
        while (pow(timeLimit / timeToDie + 1, pigs) < totalBuckets) {
            pigs++;
        }
        return pigs;
    }
};
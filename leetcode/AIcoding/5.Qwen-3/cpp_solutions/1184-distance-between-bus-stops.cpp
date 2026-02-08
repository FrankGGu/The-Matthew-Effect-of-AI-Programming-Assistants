#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int distanceBetweenBusStops(vector<int>& distance, int start, int end) {
        if (start == end) return 0;
        int total = 0;
        for (int d : distance) total += d;
        int clockwise = 0;
        if (start < end) {
            for (int i = start; i < end; ++i) {
                clockwise += distance[i];
            }
        } else {
            for (int i = start; i < distance.size(); ++i) {
                clockwise += distance[i];
            }
            for (int i = 0; i < end; ++i) {
                clockwise += distance[i];
            }
        }
        return min(clockwise, total - clockwise);
    }
};
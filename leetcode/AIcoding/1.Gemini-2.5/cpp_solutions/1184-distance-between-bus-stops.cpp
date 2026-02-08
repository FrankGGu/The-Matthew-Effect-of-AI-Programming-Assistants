#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int distanceBetweenBusStops(std::vector<int>& distance, int start, int destination) {
        int total_distance = 0;
        for (int d : distance) {
            total_distance += d;
        }

        int path1_distance = 0;
        int current_stop = start;
        int n = distance.size();

        while (current_stop != destination) {
            path1_distance += distance[current_stop];
            current_stop = (current_stop + 1) % n;
        }

        int path2_distance = total_distance - path1_distance;

        return std::min(path1_distance, path2_distance);
    }
};
#include <vector>
#include <algorithm>

class Solution {
public:
    int minTime(std::vector<int>& times) {
        std::sort(times.begin(), times.end());

        int n = times.size();
        if (n == 0) {
            return 0;
        }

        int total_time = 0;
        int left = 0;
        int right = n - 1;

        while (left <= right) {
            if (right - left == 0) { // 1 person left
                total_time += times[left];
                break;
            } else if (right - left == 1) { // 2 people left
                total_time += times[right]; 
                break;
            } else if (right - left == 2) { // 3 people left
                // The three people are times[left], times[left+1], times[left+2]
                // 1. times[left] and times[left+1] cross (time: times[left+1])
                // 2. times[left] returns (time: times[left])
                // 3. times[left] and times[left+2] cross (time: times[left+2])
                total_time += times[left+1] + times[left] + times[left+2];
                break;
            } else { // 4 or more people left
                // Consider the two slowest people: times[right] and times[right-1]

                // Option 1: Fastest person (times[left]) ferries the two slowest
                // 1. times[left] and times[right] cross (time: times[right])
                // 2. times[left] returns (time: times[left])
                // 3. times[left] and times[right-1] cross (time: times[right-1])
                // 4. times[left] returns (time: times[left])
                int cost1 = times[right] + times[left] + times[right-1] + times[left];

                // Option 2: Two fastest people (times[left], times[left+1]) ferry the two slowest
                // 1. times[left] and times[left+1] cross (time: times[left+1])
                // 2. times[left] returns (time: times[left])
                // 3. times[right-1] and times[right] cross (time: times[right])
                // 4. times[left+1] returns (time: times[left+1])
                int cost2 = times[left+1] + times[left] + times[right] + times[left+1];

                total_time += std::min(cost1, cost2);
                right -= 2; // Two people (times[right] and times[right-1]) are moved to the other side
            }
        }

        return total_time;
    }
};
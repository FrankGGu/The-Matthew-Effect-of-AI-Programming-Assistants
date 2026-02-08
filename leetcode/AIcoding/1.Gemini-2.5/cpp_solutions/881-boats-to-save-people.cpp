#include <vector>
#include <algorithm>

class Solution {
public:
    int numRescueBoats(std::vector<int>& people, int limit) {
        std::sort(people.begin(), people.end());

        int boats = 0;
        int left = 0;
        int right = people.size() - 1;

        while (left <= right) {
            boats++;
            if (people[left] + people[right] <= limit) {
                left++;
            }
            right--;
        }

        return boats;
    }
};
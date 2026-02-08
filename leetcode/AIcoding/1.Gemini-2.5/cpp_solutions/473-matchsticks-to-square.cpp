#include <vector>
#include <numeric>
#include <algorithm>
#include <functional>

class Solution {
public:
    bool makesquare(std::vector<int>& matchsticks) {
        if (matchsticks.size() < 4) {
            return false;
        }

        long long perimeter = 0;
        for (int stick : matchsticks) {
            perimeter += stick;
        }

        if (perimeter % 4 != 0) {
            return false;
        }

        long long side_length = perimeter / 4;
        std::sort(matchsticks.begin(), matchsticks.end(), std::greater<int>());

        if (matchsticks[0] > side_length) {
            return false;
        }

        std::vector<long long> sides(4, 0);
        return can_partition(0, matchsticks, sides, side_length);
    }

private:
    bool can_partition(int index, const std::vector<int>& matchsticks, std::vector<long long>& sides, long long side_length) {
        if (index == matchsticks.size()) {
            return true;
        }

        int current_stick = matchsticks[index];
        for (int i = 0; i < 4; ++i) {
            if (sides[i] + current_stick <= side_length) {
                bool skip = false;
                for (int j = 0; j < i; ++j) {
                    if (sides[j] == sides[i]) {
                        skip = true;
                        break;
                    }
                }
                if (skip) {
                    continue;
                }

                sides[i] += current_stick;
                if (can_partition(index + 1, matchsticks, sides, side_length)) {
                    return true;
                }
                sides[i] -= current_stick;
            }
        }

        return false;
    }
};
#include <vector>
#include <algorithm>

class Solution {
public:
    bool asteroidsDestroyed(int mass_int, std::vector<int>& asteroids) {
        long long current_mass = mass_int;
        std::sort(asteroids.begin(), asteroids.end());

        for (int asteroid_mass : asteroids) {
            if (current_mass >= asteroid_mass) {
                current_mass += asteroid_mass;
            } else {
                return false;
            }
        }
        return true;
    }
};
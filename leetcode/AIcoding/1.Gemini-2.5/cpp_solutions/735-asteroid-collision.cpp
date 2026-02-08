#include <vector>
#include <cmath> // For std::abs

class Solution {
public:
    std::vector<int> asteroidCollision(std::vector<int>& asteroids) {
        std::vector<int> stack;

        for (int asteroid : asteroids) {
            if (stack.empty() || asteroid > 0 || stack.back() < 0) {
                stack.push_back(asteroid);
            } else { // Current asteroid is negative, and stack.back() is positive (collision)
                bool asteroid_destroyed = false;
                while (!stack.empty() && stack.back() > 0 && asteroid < 0) {
                    int top_asteroid = stack.back();
                    if (std::abs(asteroid) > top_asteroid) {
                        stack.pop_back(); // Top asteroid explodes, current asteroid continues
                    } else if (std::abs(asteroid) == top_asteroid) {
                        stack.pop_back(); // Both explode
                        asteroid_destroyed = true;
                        break;
                    } else { // std::abs(asteroid) < top_asteroid
                        asteroid_destroyed = true; // Current asteroid explodes
                        break;
                    }
                }
                if (!asteroid_destroyed) {
                    stack.push_back(asteroid); // Current asteroid survived all collisions
                }
            }
        }

        return stack;
    }
};
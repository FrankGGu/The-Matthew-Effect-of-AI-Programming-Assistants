#include <vector>
#include <algorithm>
#include <cmath>

class Solution {
public:
    long long distSq(const std::vector<int>& p1, const std::vector<int>& p2) {
        long long dx = p1[0] - p2[0];
        long long dy = p1[1] - p2[1];
        return dx * dx + dy * dy;
    }

    bool validSquare(std::vector<int>& p1, std::vector<int>& p2, std::vector<int>& p3, std::vector<int>& p4) {
        std::vector<long long> distances;
        distances.push_back(distSq(p1, p2));
        distances.push_back(distSq(p1, p3));
        distances.push_back(distSq(p1, p4));
        distances.push_back(distSq(p2, p3));
        distances.push_back(distSq(p2, p4));
        distances.push_back(distSq(p3, p4));

        std::sort(distances.begin(), distances.end());

        // A valid square must have 6 distances:
        // 4 equal side lengths (let's call this 's_sq')
        // 2 equal diagonal lengths (let's call this 'd_sq')
        // And d_sq must be equal to 2 * s_sq (from Pythagorean theorem: s^2 + s^2 = d^2)

        // 1. All points must be distinct, so the smallest distance must be greater than 0.
        if (distances[0] == 0) {
            return false;
        }

        // 2. The first four distances must be equal (sides of the square).
        if (distances[0] != distances[1] || distances[1] != distances[2] || distances[2] != distances[3]) {
            return false;
        }

        // 3. The last two distances must be equal (diagonals of the square).
        if (distances[4] != distances[5]) {
            return false;
        }

        // 4. The squared diagonal length must be twice the squared side length.
        // The sorted distances are: s_sq, s_sq, s_sq, s_sq, d_sq, d_sq
        // So, distances[4] (d_sq) must be 2 * distances[0] (s_sq).
        if (distances[4] != 2 * distances[0]) {
            return false;
        }

        return true;
    }
};
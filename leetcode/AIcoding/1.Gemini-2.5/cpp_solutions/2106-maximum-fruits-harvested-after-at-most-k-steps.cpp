#include <vector>
#include <algorithm> // For std::min and std::max

class Solution {
public:
    long long maxFruits(std::vector<std::vector<int>>& fruits, int startPos, int k) {
        long long max_fruits = 0;
        long long current_fruits = 0;
        int n = fruits.size();
        int left = 0;

        for (int right = 0; right < n; ++right) {
            current_fruits += fruits[right][1];

            long long p_left = fruits[left][0];
            long long p_right = fruits[right][0];
            long long s_pos = startPos; 

            long long dist;
            if (s_pos < p_left) {
                dist = p_right - s_pos;
            } else if (s_pos > p_right) {
                dist = s_pos - p_left;
            } else {
                long long dist_to_left_then_right = (s_pos - p_left) + (p_right - p_left);
                long long dist_to_right_then_left = (p_right - s_pos) + (p_right - p_left);
                dist = std::min(dist_to_left_then_right, dist_to_right_then_left);
            }

            while (dist > k && left <= right) {
                current_fruits -= fruits[left][1];
                left++;

                if (left > right) {
                    break; 
                }

                p_left = fruits[left][0];
                p_right = fruits[right][0];

                if (s_pos < p_left) {
                    dist = p_right - s_pos;
                } else if (s_pos > p_right) {
                    dist = s_pos - p_left;
                } else {
                    long long dist_to_left_then_right = (s_pos - p_left) + (p_right - p_left);
                    long long dist_to_right_then_left = (p_right - s_pos) + (p_right - p_left);
                    dist = std::min(dist_to_left_then_right, dist_to_right_then_left);
                }
            }

            if (left <= right) {
                max_fruits = std::max(max_fruits, current_fruits);
            }
        }

        return max_fruits;
    }
};
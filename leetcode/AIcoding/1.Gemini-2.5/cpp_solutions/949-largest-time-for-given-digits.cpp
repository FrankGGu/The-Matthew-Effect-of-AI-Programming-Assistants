#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string largestTimeFromDigits(std::vector<int>& arr) {
        std::string max_time = "";
        std::sort(arr.begin(), arr.end());

        do {
            int h1 = arr[0];
            int h2 = arr[1];
            int m1 = arr[2];
            int m2 = arr[3];

            int hour = h1 * 10 + h2;
            int minute = m1 * 10 + m2;

            if (hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59) {
                std::string current_time_str = "";
                current_time_str += std::to_string(h1);
                current_time_str += std::to_string(h2);
                current_time_str += ":";
                current_time_str += std::to_string(m1);
                current_time_str += std::to_string(m2);

                if (max_time == "" || current_time_str > max_time) {
                    max_time = current_time_str;
                }
            }
        } while (std::next_permutation(arr.begin(), arr.end()));

        return max_time;
    }
};
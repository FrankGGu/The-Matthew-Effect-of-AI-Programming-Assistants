#include <string>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int convertTime(std::string current, std::string correct) {
        int current_hours = std::stoi(current.substr(0, 2));
        int current_minutes = std::stoi(current.substr(3, 2));
        int total_current_minutes = current_hours * 60 + current_minutes;

        int correct_hours = std::stoi(correct.substr(0, 2));
        int correct_minutes = std::stoi(correct.substr(3, 2));
        int total_correct_minutes = correct_hours * 60 + correct_minutes;

        int diff = total_correct_minutes - total_current_minutes;
        int operations = 0;

        operations += diff / 60;
        diff %= 60;

        operations += diff / 15;
        diff %= 15;

        operations += diff / 5;
        diff %= 5;

        operations += diff; // Remaining diff must be handled by 1-minute operations

        return operations;
    }
};
#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    std::string dayOfTheWeek(int day, int month, int year) {
        std::vector<std::string> days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};

        // January 1, 1971 was a Friday (index 5 in our 'days' vector)
        int reference_day_index = 5; 

        // Days in months (1-indexed, index 0 is unused for convenience)
        std::vector<int> days_in_month = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

        auto is_leap = [&](int y) {
            return (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0);
        };

        long long total_days_elapsed = 0;

        // 1. Add days for full years passed (from 1971 up to 'year - 1')
        for (int y = 1971; y < year; ++y) {
            total_days_elapsed += (is_leap(y) ? 366 : 365);
        }

        // 2. Add days for full months passed in the current 'year' (from January up to 'month - 1')
        for (int m = 1; m < month; ++m) {
            total_days_elapsed += days_in_month[m];
            if (m == 2 && is_leap(year)) { // Add an extra day for February in a leap year
                total_days_elapsed += 1;
            }
        }

        // 3. Add (day - 1) for the current month (since 'day' is 1-indexed)
        total_days_elapsed += (day - 1);

        // Calculate the final day of the week index
        return days[(reference_day_index + total_days_elapsed) % 7];
    }
};
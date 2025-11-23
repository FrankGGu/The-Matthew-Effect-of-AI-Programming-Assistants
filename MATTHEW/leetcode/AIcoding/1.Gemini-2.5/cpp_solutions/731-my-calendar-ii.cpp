#include <vector>
#include <algorithm> // For std::max and std::min

class MyCalendarTwo {
private:
    std::vector<std::pair<int, int>> calendar;
    std::vector<std::pair<int, int>> overlaps;

public:
    MyCalendarTwo() {
        // Vectors are automatically initialized as empty
    }

    bool book(int start, int end) {
        // Check for triple booking with existing overlaps
        for (const auto& p : overlaps) {
            if (std::max(start, p.first) < std::min(end, p.second)) {
                return false; // Triple booking detected
            }
        }

        // If no triple booking, identify new overlaps and add the event
        // Collect new overlaps first to ensure state is only modified if booking is successful
        for (const auto& p : calendar) {
            if (std::max(start, p.first) < std::min(end, p.second)) {
                // This intersection becomes a double-booked interval
                overlaps.push_back({std::max(start, p.first), std::min(end, p.second)});
            }
        }

        calendar.push_back({start, end});

        return true;
    }
};
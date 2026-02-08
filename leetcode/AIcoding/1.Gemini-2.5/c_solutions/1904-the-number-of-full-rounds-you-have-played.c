#include <string.h>
#include <stdlib.h>

int numberOfRounds(char *startTime, char *endTime) {
    int start_h = (startTime[0] - '0') * 10 + (startTime[1] - '0');
    int start_m = (startTime[3] - '0') * 10 + (startTime[4] - '0');

    int end_h = (endTime[0] - '0') * 10 + (endTime[1] - '0');
    int end_m = (endTime[3] - '0') * 10 + (endTime[4] - '0');

    int start_total_minutes = start_h * 60 + start_m;
    int end_total_minutes = end_h * 60 + end_m;

    if (end_total_minutes <= start_total_minutes) {
        end_total_minutes += 24 * 60; // Add 24 hours for next day
    }

    // Calculate the first valid round start time (inclusive) after or at start_total_minutes
    // A round starts at XX:00, XX:15, XX:30, or XX:45.
    // This is equivalent to ceil(start_total_minutes / 15.0) * 15
    int first_round_start = ((start_total_minutes + 14) / 15) * 15;

    // Calculate the last valid round start time (inclusive) before end_total_minutes
    // This is equivalent to floor(end_total_minutes / 15.0) * 15
    int last_round_start = (end_total_minutes / 15) * 15;

    if (last_round_start < first_round_start) {
        return 0;
    }

    return (last_round_start - first_round_start) / 15;
}
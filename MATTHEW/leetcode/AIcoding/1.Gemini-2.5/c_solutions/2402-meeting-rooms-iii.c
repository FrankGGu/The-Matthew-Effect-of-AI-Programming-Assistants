#include <stdlib.h> // For qsort, calloc, free
#include <limits.h> // For LLONG_MAX

#define MAX(a, b) ((a) > (b) ? (a) : (b))

int compareMeetings(const void* a, const void* b) {
    const int* meetingA = *(const int**)a;
    const int* meetingB = *(const int**)b;

    if (meetingA[0] != meetingB[0]) {
        return meetingA[0] - meetingB[0];
    }
    return meetingA[1] - meetingB[1];
}

int mostBooked(int n, int** meetings, int meetingsSize, int* meetingsColSize) {
    qsort(meetings, meetingsSize, sizeof(int*), compareMeetings);

    long long* room_available_time = (long long*)calloc(n, sizeof(long long));
    int* meeting_counts = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < meetingsSize; ++i) {
        long long current_meeting_start = meetings[i][0];
        long long current_meeting_end = meetings[i][1];

        int chosen_room_idx = -1;
        long long earliest_room_finish_time = LLONG_MAX;

        for (int j = 0; j < n; ++j) {
            if (room_available_time[j] < earliest_room_finish_time) {
                earliest_room_finish_time = room_available_time[j];
                chosen_room_idx = j;
            }
        }

        long long actual_meeting_start_time = MAX(current_meeting_start, earliest_room_finish_time);

        room_available_time[chosen_room_idx] = actual_meeting_start_time + (current_meeting_end - current_meeting_start);

        meeting_counts[chosen_room_idx]++;
    }

    int max_meetings = -1;
    int result_room_idx = -1;

    for (int i = 0; i < n; ++i) {
        if (meeting_counts[i] > max_meetings) {
            max_meetings = meeting_counts[i];
            result_room_idx = i;
        }
    }

    free(room_available_time);
    free(meeting_counts);

    return result_room_idx;
}
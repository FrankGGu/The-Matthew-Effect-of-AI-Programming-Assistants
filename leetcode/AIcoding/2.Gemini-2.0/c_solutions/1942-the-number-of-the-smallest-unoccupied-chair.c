#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int arrival;
    int leaving;
    int index;
} Meeting;

int compare(const void *a, const void *b) {
    return ((Meeting*)a)->arrival - ((Meeting*)b)->arrival;
}

int smallestChair(int** meetings, int meetingsSize, int* meetingsColSize, int targetFriend) {
    Meeting* meeting_arr = (Meeting*)malloc(meetingsSize * sizeof(Meeting));
    for (int i = 0; i < meetingsSize; i++) {
        meeting_arr[i].arrival = meetings[i][0];
        meeting_arr[i].leaving = meetings[i][1];
        meeting_arr[i].index = i;
    }

    qsort(meeting_arr, meetingsSize, sizeof(Meeting), compare);

    int* assignment = (int*)malloc(meetingsSize * sizeof(int));
    int* available_chairs = (int*)malloc(meetingsSize * sizeof(int));
    int available_count = 0;

    for (int i = 0; i < meetingsSize; i++) {
        available_chairs[i] = i;
    }

    int current_chair = 0;
    int chairs_used = 0;

    for (int i = 0; i < meetingsSize; i++) {

        int chair_to_assign = -1;
        if(available_count > 0){
            chair_to_assign = available_chairs[0];
            for(int j = 0; j < available_count - 1; j++){
                available_chairs[j] = available_chairs[j+1];
            }
            available_count--;
        } else {
            chair_to_assign = chairs_used++;
        }

        assignment[meeting_arr[i].index] = chair_to_assign;

        for (int j = 0; j < i; j++) {
            if (meetings[meeting_arr[j].index][1] <= meeting_arr[i].arrival) {
                available_chairs[available_count++] = assignment[meeting_arr[j].index];
            }
        }

        for(int j = 0; j < available_count; j++){
            for(int k = j+1; k < available_count; k++){
                if(available_chairs[j] > available_chairs[k]){
                    int temp = available_chairs[j];
                    available_chairs[j] = available_chairs[k];
                    available_chairs[k] = temp;
                }
            }
        }
    }

    int result = assignment[targetFriend];

    free(meeting_arr);
    free(assignment);
    free(available_chairs);

    return result;
}
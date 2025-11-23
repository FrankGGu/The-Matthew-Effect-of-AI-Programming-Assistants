#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int time;
    int worker_id;
} Event;

int compareEvents(const void *a, const void *b) {
    return ((Event*)a)->time - ((Event*)b)->time;
}

int findCrossingTime(int numWorkers, int bridgeTime[], int time[][2]) {
    int left[numWorkers];
    int right[numWorkers];
    int leftSize = numWorkers;
    int rightSize = 0;
    int busyLeft[numWorkers];
    int busyRight[numWorkers];
    int busyLeftSize = 0;
    int busyRightSize = 0;
    int time_elapsed = 0;

    for (int i = 0; i < numWorkers; i++) {
        left[i] = i;
    }

    int num_boxes = numWorkers;

    while (num_boxes > 0 || rightSize > 0 || busyRightSize > 0) {
        int next_event_time = 1e9;

        if (busyLeftSize > 0) {
            next_event_time = busyLeft[0];
        }
        if (busyRightSize > 0 && busyRight[0] < next_event_time) {
            next_event_time = busyRight[0];
        }

        if (rightSize == 0 && busyRightSize == 0 && busyLeftSize > 0 && leftSize > 0 && num_boxes <= 0)
        {
            time_elapsed = busyLeft[0];
            break;
        }

        time_elapsed = next_event_time;

        int i = 0;
        while(i < busyLeftSize)
        {
            if(busyLeft[i] <= time_elapsed)
            {
                int worker_id = -1;
                for(int j = 0; j < numWorkers; j++)
                {
                    if(left[j] == -1) continue;

                    int found = 0;
                    for(int k = 0; k < busyLeftSize; k++)
                    {
                        if(busyLeft[k] > time_elapsed)
                        {
                            break;
                        }

                        int worker_id_temp = 0;
                        for(int l = 0; l < numWorkers; l++)
                        {
                            if(left[l] != -1 && left[l] == (busyLeft[k] - time_elapsed)/bridgeTime[1])
                            {
                                worker_id_temp = left[l];
                                break;
                            }
                        }

                        if ((busyLeft[k] - time_elapsed)/bridgeTime[1] == left[j])
                        {
                            worker_id = left[j];
                            found = 1;
                            break;
                        }
                    }

                    if(found) break;
                }

                int index_to_remove = -1;
                for(int k = 0; k < busyLeftSize; k++)
                {
                    if ((busyLeft[k] - time_elapsed)/bridgeTime[1] == worker_id)
                    {
                        index_to_remove = k;
                        break;
                    }
                }

                for(int k = index_to_remove; k < busyLeftSize - 1; k++)
                {
                    busyLeft[k] = busyLeft[k+1];
                }
                busyLeftSize--;

                for(int j = 0; j < numWorkers; j++)
                {
                    if(left[j] == worker_id)
                    {
                        int worker = left[j];
                        left[j] = -1;

                        right[rightSize++] = worker;

                        break;
                    }
                }
            }
            else
            {
                break;
            }
        }

        i = 0;
        while(i < busyRightSize)
        {
            if(busyRight[i] <= time_elapsed)
            {
                int worker_id = -1;
                for(int j = 0; j < numWorkers; j++)
                {
                    if(right[j] == -1) continue;

                    int found = 0;
                    for(int k = 0; k < busyRightSize; k++)
                    {
                        if(busyRight[k] > time_elapsed)
                        {
                            break;
                        }

                        int worker_id_temp = 0;
                        for(int l = 0; l < numWorkers; l++)
                        {
                            if(right[l] != -1 && right[l] == (busyRight[k] - time_elapsed)/bridgeTime[1])
                            {
                                worker_id_temp = right[l];
                                break;
                            }
                        }

                        if ((busyRight[k] - time_elapsed)/bridgeTime[1] == right[j])
                        {
                            worker_id = right[j];
                            found = 1;
                            break;
                        }
                    }

                    if(found) break;
                }

                int index_to_remove = -1;
                for(int k = 0; k < busyRightSize; k++)
                {
                    if ((busyRight[k] - time_elapsed)/bridgeTime[1] == worker_id)
                    {
                        index_to_remove = k;
                        break;
                    }
                }

                for(int k = index_to_remove; k < busyRightSize - 1; k++)
                {
                    busyRight[k] = busyRight[k+1];
                }
                busyRightSize--;

                for(int j = 0; j < numWorkers; j++)
                {
                    if(right[j] == worker_id)
                    {
                        int worker = right[j];
                        right[j] = -1;

                        left[leftSize++] = worker;

                        break;
                    }
                }
            }
            else
            {
                break;
            }
        }

        int best_worker_left = -1;
        int best_time_left = -1;

        if(leftSize > 0)
        {
            for(int j = 0; j < numWorkers; j++)
            {
                if(left[j] != -1)
                {
                    if(best_worker_left == -1 || time[left[j]][0] + time[left[j]][2] > best_time_left)
                    {
                        best_worker_left = left[j];
                        best_time_left = time[left[j]][0] + time[left[j]][2];
                    }
                }
            }
        }

        int best_worker_right = -1;
        int best_time_right = -1;

        if(rightSize > 0)
        {
            for(int j = 0; j < numWorkers; j++)
            {
                if(right[j] != -1)
                {
                    if(best_worker_right == -1 || time[right[j]][0] + time[right[j]][2] > best_time_right)
                    {
                        best_worker_right = right[j];
                        best_time_right = time[right[j]][0] + time[right[j]][2];
                    }
                }
            }
        }

        if (rightSize > 0)
        {
            int worker_id = best_worker_right;
            int worker_index = -1;
            for(int j = 0; j < numWorkers; j++)
            {
                if(right[j] == worker_id)
                {
                    worker_index = j;
                    break;
                }
            }

            if(worker_index != -1)
            {
                for(int k = worker_index; k < rightSize - 1; k++)
                {
                    right[k] = right[k+1];
                }
                rightSize--;

                busyRight[busyRightSize++] = time_elapsed + time[worker_id][2] + bridgeTime[1];
            }
        }
        else if (leftSize > 0 && num_boxes > 0)
        {
             int worker_id = best_worker_left;
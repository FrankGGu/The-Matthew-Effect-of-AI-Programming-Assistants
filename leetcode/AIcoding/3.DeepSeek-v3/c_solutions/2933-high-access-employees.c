#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int times[1000];
    int count;
} Employee;

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int timeToMinutes(char* time) {
    int hours = (time[0] - '0') * 10 + (time[1] - '0');
    int minutes = (time[2] - '0') * 10 + (time[3] - '0');
    return hours * 60 + minutes;
}

char** findHighAccessEmployees(char*** access_times, int access_timesSize, int* access_timesColSize, int* returnSize) {
    Employee* employees = (Employee*)malloc(access_timesSize * sizeof(Employee));
    int empCount = 0;

    for (int i = 0; i < access_timesSize; i++) {
        char* name = access_times[i][0];
        int time = timeToMinutes(access_times[i][1]);

        int found = 0;
        for (int j = 0; j < empCount; j++) {
            if (strcmp(employees[j].name, name) == 0) {
                employees[j].times[employees[j].count++] = time;
                found = 1;
                break;
            }
        }

        if (!found) {
            employees[empCount].name = name;
            employees[empCount].times[0] = time;
            employees[empCount].count = 1;
            empCount++;
        }
    }

    for (int i = 0; i < empCount; i++) {
        qsort(employees[i].times, employees[i].count, sizeof(int), cmp);
    }

    char** result = (char**)malloc(empCount * sizeof(char*));
    int resCount = 0;

    for (int i = 0; i < empCount; i++) {
        if (employees[i].count < 3) continue;

        for (int j = 0; j <= employees[i].count - 3; j++) {
            if (employees[i].times[j + 2] - employees[i].times[j] < 60) {
                result[resCount] = (char*)malloc(11 * sizeof(char));
                strcpy(result[resCount], employees[i].name);
                resCount++;
                break;
            }
        }
    }

    free(employees);
    *returnSize = resCount;
    return result;
}
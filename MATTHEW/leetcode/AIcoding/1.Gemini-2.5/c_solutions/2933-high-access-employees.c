#include <stdlib.h> // For malloc, free, qsort
#include <string.h> // For strcmp

typedef struct {
    char* name;
    int time_in_minutes;
} AccessRecord;

int compareAccessRecords(const void* a, const void* b) {
    AccessRecord* recA = (AccessRecord*)a;
    AccessRecord* recB = (AccessRecord*)b;

    int name_cmp = strcmp(recA->name, recB->name);
    if (name_cmp != 0) {
        return name_cmp;
    }
    return recA->time_in_minutes - recB->time_in_minutes;
}

int compareStrings(const void* a, const void* b) {
    return strcmp(*(char**)a, *(char**)b);
}

int parseTime(char* time_str) {
    int hour = (time_str[0] - '0') * 10 + (time_str[1] - '0');
    int minute = (time_str[3] - '0') * 10 + (time_str[4] - '0');
    return hour * 60 + minute;
}

char*** highAccessEmployees(char*** accessTimes, int accessTimesSize, int* accessTimesColSize, int* returnSize) {
    if (accessTimesSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    // 1. Convert input into an array of AccessRecord structs
    AccessRecord* records = (AccessRecord*)malloc(accessTimesSize * sizeof(AccessRecord));
    for (int i = 0; i < accessTimesSize; ++i) {
        records[i].name = accessTimes[i][0]; // Pointer to original string
        records[i].time_in_minutes = parseTime(accessTimes[i][1]);
    }

    // 2. Sort the AccessRecord array
    qsort(records, accessTimesSize, sizeof(AccessRecord), compareAccessRecords);

    // 3. Identify high-access employees
    // This array will store pointers to the names of high-access employees.
    // Max size is accessTimesSize (if all records are for different high-access employees).
    char** temp_result_names = (char**)malloc(accessTimesSize * sizeof(char*)); 
    int temp_result_count = 0;

    int i = 0;
    while (i < accessTimesSize) {
        char* current_employee_name = records[i].name;
        int start_idx = i;

        // Find all records for the current employee
        while (i < accessTimesSize && strcmp(records[i].name, current_employee_name) == 0) {
            i++;
        }
        // records[start_idx...i-1] are for current_employee_name, and are sorted by time

        int num_times_for_employee = i - start_idx;

        if (num_times_for_employee >= 3) {
            for (int j = 0; j <= num_times_for_employee - 3; ++j) {
                // Check if 3rd access (records[start_idx + j + 2]) is within 60 minutes of 1st access (records[start_idx + j])
                // The window is [records[start_idx + j], records[start_idx + j] + 59 minutes]
                if (records[start_idx + j + 2].time_in_minutes - records[start_idx + j].time_in_minutes < 60) {
                    temp_result_names[temp_result_count++] = current_employee_name;
                    break; // Found high access for this employee, move to the next employee
                }
            }
        }
    }

    // 4. Sort the collected high-access employee names lexicographically
    qsort(temp_result_names, temp_result_count, sizeof(char*), compareStrings);

    // 5. Allocate and populate the final result array
    // LeetCode's C solutions for `char***` return type usually expect `char**`
    // where `*returnSize` is the number of strings.
    char** final_result = (char**)malloc(temp_result_count * sizeof(char*)); 
    for (int k = 0; k < temp_result_count; ++k) {
        final_result[k] = temp_result_names[k]; // Copy the pointer to the name string
    }
    *returnSize = temp_result_count;

    // Free temporary memory
    free(records);
    free(temp_result_names); 

    // Return the array of string pointers, cast to char*** to match function signature
    return (char***)final_result;
}
#include <stdlib.h> // For malloc, free, qsort
#include <string.h> // For strcmp, strdup
#include <stdio.h>  // For sscanf

typedef struct {
    char *name;
    int time_minutes; // Total minutes from midnight (e.g., "23:59" -> 23*60 + 59)
} Entry;

int compareEntries(const void *a, const void *b) {
    Entry *entryA = (Entry *)a;
    Entry *entryB = (Entry *)b;

    int name_cmp = strcmp(entryA->name, entryB->name);
    if (name_cmp != 0) {
        return name_cmp;
    }
    return entryA->time_minutes - entryB->time_minutes;
}

char **alertNames(char **keyName, int keyNameSize, char **keyTime, int keyTimeSize, int *returnSize) {
    // 1. Parse input data into an array of Entry structs
    Entry *entries = (Entry *)malloc(keyNameSize * sizeof(Entry));
    if (entries == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < keyNameSize; i++) {
        entries[i].name = strdup(keyName[i]);
        if (entries[i].name == NULL) {
            for (int k = 0; k < i; k++) {
                free(entries[k].name);
            }
            free(entries);
            *returnSize = 0;
            return NULL;
        }

        int hour, minute;
        sscanf(keyTime[i], "%d:%d", &hour, &minute);
        entries[i].time_minutes = hour * 60 + minute;
    }

    // 2. Sort all entries. This groups all entries for the same person together
    // and orders their access times chronologically.
    qsort(entries, keyNameSize, sizeof(Entry), compareEntries);

    // 3. Process sorted entries to find alerts.
    // We'll store alerted names in a temporary array. Since entries are sorted by name,
    // we can add each unique alerted person's name directly, and they will naturally
    // be in alphabetical order.
    char **temp_alerted_names = (char **)malloc(keyNameSize * sizeof(char *));
    if (temp_alerted_names == NULL) {
        for (int i = 0; i < keyNameSize; i++) {
            free(entries[i].name);
        }
        free(entries);
        *returnSize = 0;
        return NULL;
    }
    int temp_alerted_count = 0;

    // Iterate through the sorted entries array
    // 'i' marks the start of the current person's entries
    for (int i = 0; i < keyNameSize; ) {
        char *current_person_name = entries[i].name;
        int j = i;
        // Find all entries for the current person
        while (j < keyNameSize && strcmp(entries[j].name, current_person_name) == 0) {
            j++;
        }
        // Entries for current_person_name are from index 'i' to 'j-1'
        int person_entry_count = j - i;

        // Check if this person has 3 or more key-card times
        if (person_entry_count >= 3) {
            // Use a sliding window of three entries to check the 60-minute condition
            for (int k = 0; k <= person_entry_count - 3; k++) {
                // Check if the time difference between the 1st and 3rd entry in the window is <= 60 minutes
                if (entries[i + k + 2].time_minutes - entries[i + k].time_minutes <= 60) {
                    // Alert triggered for this person.
                    // Add their name to the temp_alerted_names list.
                    // Since we process people in alphabetical order, and add each person's name at most once,
                    // the resulting list will be unique and sorted alphabetically.
                    temp_alerted_names[temp_alerted_count++] = strdup(current_person_name);
                    if (temp_alerted_names[temp_alerted_count - 1] == NULL) {
                        for (int l = 0; l < i; l++) free(entries[l].name);
                        free(entries);
                        for (int l = 0; l < temp_alerted_count - 1; l++) free(temp_alerted_names[l]);
                        free(temp_alerted_names);
                        *returnSize = 0;
                        return NULL;
                    }
                    break; // No need to check further for this person, one alert is enough
                }
            }
        }
        i = j; // Move 'i' to the start of the next person's entries
    }

    // 4. Prepare the final result array.
    // The names in temp_alerted_names are already unique and in alphabetical order.
    char **result_names = (char **)malloc(temp_alerted_count * sizeof(char *));
    if (result_names == NULL) {
        for (int i = 0; i < keyNameSize; i++) free(entries[i].name);
        free(entries);
        for (int i = 0; i < temp_alerted_count; i++) free(temp_alerted_names[i]);
        free(temp_alerted_names);
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < temp_alerted_count; i++) {
        result_names[i] = temp_alerted_names[i]; // Transfer ownership of strdup'd strings
    }
    free(temp_alerted_names); // Free the temporary array itself, not its contents (ownership transferred)

    *returnSize = temp_alerted_count;

    // Free intermediate memory: the names and the entries array
    for (int i = 0; i < keyNameSize; i++) {
        free(entries[i].name);
    }
    free(entries);

    return result_names;
}
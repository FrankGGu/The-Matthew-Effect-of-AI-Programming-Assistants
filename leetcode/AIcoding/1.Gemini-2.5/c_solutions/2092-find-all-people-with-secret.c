#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct {
    int p1, p2, time;
} Meeting;

int compareMeetings(const void* a, const void* b) {
    return ((Meeting*)a)->time - ((Meeting*)b)->time;
}

int* parent;
int* ranks;

int find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent[i]);
}

void unite(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);

    if (root_i != root_j) {
        if (ranks[root_i] < ranks[root_j]) {
            parent[root_i] = root_j;
        } else if (ranks[root_i] > ranks[root_j]) {
            parent[root_j] = root_i;
        } else {
            parent[root_j] = root_i;
            ranks[root_i]++;
        }
    }
}

bool* knowsSecret;

int* findAllPeople(int n, int** meetings, int meetingsSize, int* meetingsColSize, int firstPerson, int* returnSize) {
    // Allocate global DSU arrays
    parent = (int*)malloc(n * sizeof(int));
    ranks = (int*)malloc(n * sizeof(int));
    knowsSecret = (bool*)malloc(n * sizeof(bool));

    // Initialize DSU structure and secret knowledge status for all people
    for (int i = 0; i < n; ++i) {
        parent[i] = i;
        ranks[i] = 0;
        knowsSecret[i] = false;
    }

    // Person 0 and firstPerson initially know the secret
    knowsSecret[0] = true;
    knowsSecret[firstPerson] = true;

    // Convert input meetings to our struct for easier sorting
    Meeting* meeting_structs = (Meeting*)malloc(meetingsSize * sizeof(Meeting));
    for (int i = 0; i < meetingsSize; ++i) {
        meeting_structs[i].p1 = meetings[i][0];
        meeting_structs[i].p2 = meetings[i][1];
        meeting_structs[i].time = meetings[i][2];
    }

    // Sort meetings by time
    qsort(meeting_structs, meetingsSize, sizeof(Meeting), compareMeetings);

    // Temporary storage for people involved in the current time slice of meetings
    // Max 2 * meetingsSize people can be involved if all meetings are at the same time.
    int* temp_people = (int*)malloc(2 * meetingsSize * sizeof(int)); 
    int temp_count;

    int i = 0;
    while (i < meetingsSize) {
        int current_time = meeting_structs[i].time;
        temp_count = 0; // Reset count for current time slice

        int j = i;
        // Process all meetings that occur at the current_time
        while (j < meetingsSize && meeting_structs[j].time == current_time) {
            int p1 = meeting_structs[j].p1;
            int p2 = meeting_structs[j].p2;

            // Store people involved for later processing (duplicates are fine)
            temp_people[temp_count++] = p1;
            temp_people[temp_count++] = p2;

            // Unite them in the DSU
            unite(p1, p2);
            j++;
        }

        // After all unions for current_time are done
        // Determine which components know the secret based on existing knowledge
        bool* roots_with_secret = (bool*)calloc(n, sizeof(bool)); // Initialize to false

        // For each person involved in this batch of meetings, check if they know the secret.
        // If so, mark their component's root as knowing the secret.
        for (int k = 0; k < temp_count; ++k) {
            int person = temp_people[k];
            if (knowsSecret[person]) {
                roots_with_secret[find(person)] = true;
            }
        }

        // Propagate secret knowledge and reset DSU for those who didn't learn
        for (int k = 0; k < temp_count; ++k) {
            int person = temp_people[k];
            if (roots_with_secret[find(person)]) {
                // If the component of this person knows the secret, this person learns it
                knowsSecret[person] = true;
            } else {
                // This person's component did not learn the secret from this batch of meetings.
                // Reset their DSU parent to themselves, effectively isolating them for the next time slice.
                // This prevents secret propagation from "past" unlearned connections.
                parent[person] = person;
                ranks[person] = 0; // Reset rank too
            }
        }
        free(roots_with_secret); // Free temporary array

        i = j; // Move to the next batch of meetings
    }

    // Collect all people who know the secret into the result array
    int current_return_size = 0;
    for (int k = 0; k < n; ++k) {
        if (knowsSecret[k]) {
            current_return_size++;
        }
    }

    int* result = (int*)malloc(current_return_size * sizeof(int));
    int result_idx = 0;
    for (int k = 0; k < n; ++k) {
        if (knowsSecret[k]) {
            result[result_idx++] = k;
        }
    }

    *returnSize = current_return_size;

    // Free all allocated memory
    free(parent);
    free(ranks);
    free(knowsSecret);
    free(meeting_structs);
    free(temp_people);

    return result;
}
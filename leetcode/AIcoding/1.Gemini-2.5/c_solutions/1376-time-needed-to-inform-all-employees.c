#include <stdlib.h> // For malloc, calloc, free

int max(int a, int b) {
    return a > b ? a : b;
}

int dfs(int employee_id, int* informTime, int** adj, int* subordinate_counts) {
    // If the employee has no direct reports (subordinates), they don't need to inform anyone further.
    // So, they contribute 0 additional time to the total informing chain from this point downwards.
    if (subordinate_counts[employee_id] == 0) {
        return 0;
    }

    int max_time_from_subordinates = 0;
    // Iterate through all direct reports of the current employee.
    for (int i = 0; i < subordinate_counts[employee_id]; i++) {
        int subordinate_id = adj[employee_id][i];
        // Recursively call DFS for each subordinate.
        // We take the maximum time among all paths originating from this employee's direct reports.
        max_time_from_subordinates = max(max_time_from_subordinates, dfs(subordinate_id, informTime, adj, subordinate_counts));
    }

    // The total time for this employee to inform everyone in their subtree is:
    // their own informTime + the maximum time it takes for any of their subordinates' subtrees to be informed.
    return informTime[employee_id] + max_time_from_subordinates;
}

int numOfMinutes(int n, int headID, int* manager, int managerSize, int* informTime, int informTimeSize) {
    // Create an array to store the count of direct reports for each employee.
    // This helps in pre-allocating memory for the adjacency list efficiently.
    int* subordinate_counts = (int*)calloc(n, sizeof(int));
    if (subordinate_counts == NULL) {
        return -1; // Memory allocation failed
    }

    // Populate subordinate_counts by iterating through the manager array.
    for (int i = 0; i < n; i++) {
        if (manager[i] != -1) { // If employee i has a manager
            subordinate_counts[manager[i]]++;
        }
    }

    // Create an adjacency list (array of pointers to int arrays) to store direct reports.
    int** adj = (int**)malloc(n * sizeof(int*));
    if (adj == NULL) {
        free(subordinate_counts);
        return -1; // Memory allocation failed
    }

    // Create an array to keep track of the current index for inserting subordinates into each manager's list.
    int* current_subordinate_indices = (int*)calloc(n, sizeof(int));
    if (current_subordinate_indices == NULL) {
        free(subordinate_counts);
        free(adj); // Free partially allocated adj
        return -1; // Memory allocation failed
    }

    // Allocate memory for each manager's list of subordinates.
    for (int i = 0; i < n; i++) {
        if (subordinate_counts[i] > 0) {
            adj[i] = (int*)malloc(subordinate_counts[i] * sizeof(int));
            if (adj[i] == NULL) {
                // Clean up already allocated memory in case of failure
                for (int j = 0; j < i; j++) {
                    if (adj[j] != NULL) free(adj[j]);
                }
                free(adj);
                free(subordinate_counts);
                free(current_subordinate_indices);
                return -1; // Memory allocation failed
            }
        } else {
            adj[i] = NULL; // No subordinates, no memory needed for this list
        }
    }

    // Populate the adjacency list.
    for (int i = 0; i < n; i++) {
        if (manager[i] != -1) {
            int mgr_id = manager[i];
            adj[mgr_id][current_subordinate_indices[mgr_id]] = i;
            current_subordinate_indices[mgr_id]++;
        }
    }

    // Start the DFS from the head of the company (headID).
    int result = dfs(headID, informTime, adj, subordinate_counts);

    // Free all dynamically allocated memory to prevent memory leaks.
    for (int i = 0; i < n; i++) {
        if (adj[i] != NULL) {
            free(adj[i]);
        }
    }
    free(adj);
    free(subordinate_counts);
    free(current_subordinate_indices);

    return result;
}
#include <stdlib.h> // For malloc

static int cells_to_int(int* cells, int cellsSize) {
    int mask = 0;
    for (int i = 0; i < cellsSize; ++i) {
        if (cells[i] == 1) {
            mask |= (1 << i);
        }
    }
    return mask;
}

int* prisonAfterNDays(int* cells, int cellsSize, int N) {
    // current_cells_arr will hold the state of the cells at the beginning of the current day.
    int current_cells_arr[cellsSize];
    for (int i = 0; i < cellsSize; ++i) {
        current_cells_arr[i] = cells[i];
    }

    // visited_masks stores the day_idx when a specific cell state (represented by its integer mask)
    // was first encountered. Initialize with -1 to indicate not visited.
    // There are 2^8 = 256 possible states for 8 cells.
    int visited_masks[256];
    for (int i = 0; i < 256; ++i) {
        visited_masks[i] = -1;
    }

    // states_in_order stores the actual cell configurations for each day_idx.
    // It needs to store up to 256 unique states (indexed 0 to 255).
    int states_in_order[256][cellsSize];

    // Simulate day by day
    // day_idx represents the current day number, starting from 0 for the initial state.
    for (long long day_idx = 0; day_idx < N; ++day_idx) {
        int current_mask = cells_to_int(current_cells_arr, cellsSize);

        // Check if the current state has been visited before
        if (visited_masks[current_mask] != -1) {
            // Cycle detected!
            int first_occurrence_day = visited_masks[current_mask];
            int cycle_length = (int)(day_idx - first_occurrence_day);

            // Calculate the remaining effective days to simulate within the cycle
            long long remaining_days_to_simulate = N - day_idx;
            long long offset_in_cycle = remaining_days_to_simulate % cycle_length;

            // The final state is the one that occurred at `first_occurrence_day + offset_in_cycle`.
            int final_state_idx = first_occurrence_day + (int)offset_in_cycle;

            // Allocate memory for the result and copy the final state
            int* result = (int*)malloc(cellsSize * sizeof(int));
            if (result == NULL) {
                return NULL; 
            }
            for (int i = 0; i < cellsSize; ++i) {
                result[i] = states_in_order[final_state_idx][i];
            }
            return result;
        }

        // If not visited, record the current state and its day_idx
        visited_masks[current_mask] = (int)day_idx;
        for (int i = 0; i < cellsSize; ++i) {
            states_in_order[day_idx][i] = current_cells_arr[i];
        }

        // Calculate the next state
        int next_cells_arr[cellsSize];
        next_cells_arr[0] = 0; // First cell always becomes 0
        next_cells_arr[cellsSize - 1] = 0; // Last cell always becomes 0

        for (int i = 1; i < cellsSize - 1; ++i) {
            if (current_cells_arr[i - 1] == current_cells_arr[i + 1]) {
                next_cells_arr[i] = 1;
            } else {
                next_cells_arr[i] = 0;
            }
        }

        // Update current_cells_arr for the next iteration
        for (int i = 0; i < cellsSize; ++i) {
            current_cells_arr[i] = next_cells_arr[i];
        }
    }

    // If the loop finishes without detecting a cycle (i.e., N was small enough, <= 256 days)
    // The `current_cells_arr` holds the state after N days.
    int* result = (int*)malloc(cellsSize * sizeof(int));
    if (result == NULL) {
        return NULL;
    }
    for (int i = 0; i < cellsSize; ++i) {
        result[i] = current_cells_arr[i];
    }
    return result;
}
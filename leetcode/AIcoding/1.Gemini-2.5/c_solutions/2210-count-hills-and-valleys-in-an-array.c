int countHillsAndValleys(int* nums, int numsSize) {
    if (numsSize < 3) {
        return 0;
    }

    int count = 0;
    // prev_val stores the last distinct value encountered to the left of the current index.
    // Initialize with the first element.
    int prev_val = nums[0]; 

    // Iterate from the second element up to the second-to-last element.
    // The first and last elements cannot be hills or valleys as they don't have two neighbors.
    for (int i = 1; i < numsSize - 1; ++i) {
        // If the current number is the same as the previous distinct number,
        // it's part of a plateau. We effectively skip it to find the next distinct number.
        if (nums[i] == prev_val) {
            continue;
        }

        // nums[i] is distinct from prev_val.
        // Now we need to find the next distinct value to its right.
        int next_val_idx = -1;
        for (int k = i + 1; k < numsSize; ++k) {
            if (nums[k] != nums[i]) {
                next_val_idx = k;
                break;
            }
        }

        // If no distinct value is found to the right, nums[i] cannot form a hill/valley
        // with prev_val and a next distinct value.
        if (next_val_idx == -1) {
            // Update prev_val to nums[i] for consistency, though no more hills/valleys
            // can be formed with nums[i] as the middle element.
            prev_val = nums[i]; 
            continue;
        }

        int current_val = nums[i];
        int next_val = nums[next_val_idx];

        // Check if current_val forms a hill
        if (current_val > prev_val && current_val > next_val) {
            count++;
        }
        // Check if current_val forms a valley
        else if (current_val < prev_val && current_val < next_val) {
            count++;
        }

        // Update prev_val to the current distinct number (nums[i]).
        // This is crucial for correctly identifying hills/valleys when plateaus are present.
        prev_val = current_val;
    }

    return count;
}
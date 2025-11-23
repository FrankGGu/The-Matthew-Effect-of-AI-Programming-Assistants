#include <stdlib.h> // Required for malloc
#include <stdbool.h> // Required for bool type

#include <vector>
#include <queue>
#include <set>
#include <algorithm> // Required for std::max, std::min

int* minReverseOperations(int n, int p, int* banned, int bannedSize, int k) {
    // Initialize the answer array with -1, indicating unreachable positions.
    int* ans = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        ans[i] = -1;
    }

    // Use a std::set to keep track of indices that are not yet visited and not banned.
    // This allows for efficient range queries and removal of visited elements.
    std::set<int> available_indices;
    for (int i = 0; i < n; ++i) {
        available_indices.insert(i);
    }

    // Remove all banned indices from the set of available indices.
    for (int i = 0; i < bannedSize; ++i) {
        available_indices.erase(banned[i]);
    }

    // Initialize a BFS queue.
    std::queue<int> q;

    // Start BFS from the initial position 'p'.
    ans[p] = 0; // Distance to 'p' from 'p' is 0.
    q.push(p);
    available_indices.erase(p); // Mark 'p' as visited by removing it from available_indices.

    // Perform BFS.
    while (!q.empty()) {
        int curr = q.front();
        q.pop();
        int curr_dist = ans[curr];

        // Calculate the minimum and maximum possible starting positions 'l'
        // for a subarray of length 'k' that includes 'curr'.
        // Constraints for 'l':
        // 1. 0 <= l (subarray must start within bounds)
        // 2. l + k - 1 < n (subarray must end within bounds) => l <= n - k
        // 3. l <= curr (subarray must start at or before 'curr')
        // 4. curr <= l + k - 1 (subarray must end at or after 'curr') => l >= curr - k + 1
        int L_min = std::max(0, curr - k + 1);
        int L_max = std::min(n - k, curr);

        // Calculate the minimum and maximum possible 'next_pos' values.
        // If 'curr' is at index 'i' in a subarray [l, l+k-1],
        // after reversing, it moves to l + (l + k - 1) - curr = 2*l + k - 1 - curr.
        int min_next_pos = 2 * L_min + k - 1 - curr;
        int max_next_pos = 2 * L_max + k - 1 - curr;

        // Determine the required parity for 'next_pos'.
        // All 'next_pos' values reachable from 'curr' will have the same parity.
        // (X % 2 + 2) % 2 is used to ensure a non-negative result for the modulo operation
        // in C/C++ when X might be negative.
        int target_parity = ((k - 1 - curr) % 2 + 2) % 2;

        // Iterate through the available_indices set to find valid next positions.
        // `lower_bound` efficiently finds the first element >= min_next_pos.
        auto it = available_indices.lower_bound(min_next_pos);

        // Iterate while the iterator is valid and the current element is within max_next_pos.
        while (it != available_indices.end() && *it <= max_next_pos) {
            int next_node = *it;

            // Check if the next_node has the required parity.
            if ((next_node % 2) == target_parity) {
                // If it's a valid next position, update its distance, add to queue, and remove from set.
                ans[next_node] = curr_dist + 1;
                q.push(next_node);
                // `erase(it)` returns an iterator to the element following the one erased,
                // which is efficient for iterating and removing.
                it = available_indices.erase(it); 
            } else {
                // If parity doesn't match, skip this node and move to the next.
                ++it; 
            }
        }
    }

    return ans;
}
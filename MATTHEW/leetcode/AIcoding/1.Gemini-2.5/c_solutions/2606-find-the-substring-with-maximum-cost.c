#include <string.h>
#include <stdlib.h> // For abs, but not needed here. For max, can use ternary or implement.
#include <limits.h> // For INT_MIN, but not strictly needed with correct Kadane's initialization.

int maximumCostSubstring(char * s, char * chars, int* vals, int valsSize){
    int char_costs[26];

    // Initialize default costs (a=1, b=2, ..., z=26)
    for (int i = 0; i < 26; i++) {
        char_costs[i] = i + 1;
    }

    // Update costs based on 'chars' and 'vals'
    for (int i = 0; i < valsSize; i++) {
        char_costs[chars[i] - 'a'] = vals[i];
    }

    int n = strlen(s);
    if (n == 0) {
        return 0; // Though problem constraints usually state s has length >= 1
    }

    int current_max = 0;
    int global_max = 0; // The problem asks for maximum cost, so 0 is a valid initial value
                        // if all substring costs can be negative, and an empty substring
                        // is considered to have cost 0. However, "substring" implies non-empty.
                        // Kadane's algorithm correctly handles this by allowing current_max
                        // to reset to 0, effectively starting a new substring.
                        // If all possible substring costs are negative, the largest (least negative)
                        // single character cost will be returned.

    for (int i = 0; i < n; i++) {
        int char_val = char_costs[s[i] - 'a'];

        current_max += char_val;

        if (current_max < 0) {
            current_max = 0; // If current sum becomes negative, it's better to start a new substring
        }

        if (current_max > global_max) {
            global_max = current_max;
        }
    }

    // Edge case: if all characters have negative costs, and the standard Kadane's
    // with current_max reset to 0 would return 0.
    // In this scenario, the maximum cost is the largest single character cost.
    // The problem states "substring", implying non-empty.
    // If global_max is still 0 after the loop and there was at least one character,
    // it means all possible sums were <= 0. In this case, we need to find the maximum
    // individual character cost.
    // A more robust Kadane's initialization for this:
    // int current_max = char_costs[s[0] - 'a'];
    // int global_max = char_costs[s[0] - 'a'];
    // for i=1 to n-1:
    //   current_max = (char_val > current_max + char_val) ? char_val : (current_max + char_val);
    //   global_max = (global_max > current_max) ? global_max : current_max;
    // This handles all negative numbers correctly.
    // Let's refactor to that standard Kadane's.

    current_max = char_costs[s[0] - 'a'];
    global_max = char_costs[s[0] - 'a'];

    for (int i = 1; i < n; i++) {
        int char_val = char_costs[s[i] - 'a'];

        // current_max = max(char_val, current_max + char_val)
        if (char_val > current_max + char_val) {
            current_max = char_val;
        } else {
            current_max = current_max + char_val;
        }

        // global_max = max(global_max, current_max)
        if (current_max > global_max) {
            global_max = current_max;
        }
    }

    return global_max;
}
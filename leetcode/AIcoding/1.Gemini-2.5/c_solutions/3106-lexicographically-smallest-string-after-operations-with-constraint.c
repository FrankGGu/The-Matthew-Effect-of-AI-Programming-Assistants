#include <string.h>

char *getSmallestString(char *s, int k) {
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        if (k == 0) {
            break;
        }

        char current_char = s[i];

        // Calculate cost to change current_char to 'a'
        // Option 1: Shift forward (e.g., 'c' -> 'b' -> 'a')
        int dist_to_a_forward = current_char - 'a';

        // Option 2: Shift backward (e.g., 'c' -> 'd' ... -> 'z' -> 'a')
        // No, it's 'c' -> 'b' -> 'a' or 'c' -> 'd' -> ... -> 'z' -> 'a'.
        // The problem states 's[i] + 1' or 's[i] - 1', with 'a' - 1 = 'z' and 'z' + 1 = 'a'.
        // So 'c' to 'a' can be 2 steps ('c'->'b'->'a')
        // Or 'c' to 'a' can be 24 steps ('c'->'d'...->'z'->'a')
        // The distance is min(abs(c - target), 26 - abs(c - target))
        // Here, target is 'a'. So, min(current_char - 'a', 'a' - current_char + 26)
        // Or, more simply, min(current_char - 'a', 'z' - current_char + 1)
        int dist_to_a_backward = ('z' - current_char + 1);

        int cost_to_make_a = (dist_to_a_forward <= dist_to_a_backward) ? dist_to_a_forward : dist_to_a_backward;

        if (k >= cost_to_make_a) {
            s[i] = 'a';
            k -= cost_to_make_a;
        } else {
            // Not enough k to make it 'a'. Use remaining k to make it as small as possible.
            // We want to shift 'current_char' 'k' steps towards 'a'.
            // This means decreasing its value relative to 'a'.
            // Example: 't' (value 19), k=3. New char is 'q' (value 16).
            // (19 - 3 + 26) % 26 = 16.
            s[i] = 'a' + ((current_char - 'a' - k + 26) % 26);
            k = 0; // All remaining operations are used on this character
        }
    }

    return s;
}
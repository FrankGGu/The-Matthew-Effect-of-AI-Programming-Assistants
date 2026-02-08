#include <string.h>

int partitionString(char * s) {
    int partitions = 0;
    int seen[26]; // To track characters seen in the current partition, 'a' through 'z'

    int i = 0;
    while (s[i] != '\0') {
        partitions++;
        // Reset seen array for the new partition
        memset(seen, 0, sizeof(seen)); 

        // Build the current partition
        while (s[i] != '\0') {
            int char_idx = s[i] - 'a';
            if (seen[char_idx]) {
                // Character already seen in current partition, so this partition ends here.
                // The current character s[i] will be the start of the next partition.
                break; 
            }
            seen[char_idx] = 1; // Mark character as seen in current partition
            i++; // Move to the next character in the string
        }
    }

    return partitions;
}
#include <string.h> // For memset

long long wonderfulSubstrings(char * s){
    // Max mask is 2^10 - 1 = 1023. So 1024 elements are needed for the frequency array.
    // Each count can go up to s.length, which is 10^5. long long is appropriate for count elements.
    long long count[1024]; 
    memset(count, 0, sizeof(count)); 

    long long ans = 0;
    int current_mask = 0;

    // The empty prefix (before index 0) has a mask of 0.
    // This is crucial for correctly counting substrings that start from index 0.
    count[0] = 1; 

    for (int i = 0; s[i] != '\0'; i++) {
        int char_idx = s[i] - 'a';
        current_mask ^= (1 << char_idx); // Flip the bit for the current character

        // Case 1: The substring s[j...i] has all characters appearing an even number of times.
        // This means the prefix_mask up to index i (current_mask) is the same as
        // the prefix_mask up to index j-1.
        // We add the number of times this 'current_mask' has been seen before.
        ans += count[current_mask];

        // Case 2: The substring s[j...i] has exactly one character appearing an odd number of times.
        // This means the XOR of prefix_mask[i] and prefix_mask[j-1] results in a mask
        // with exactly one bit set.
        // In other words, prefix_mask[j-1] must be equal to (current_mask XOR (1 << k))
        // for some k (where k represents the character that appears an odd number of times).
        for (int k = 0; k < 10; k++) { // Iterate through all possible 10 characters ('a' through 'j')
            int target_mask = current_mask ^ (1 << k);
            ans += count[target_mask];
        }

        // Increment the count for the current prefix mask, as we have encountered it now.
        count[current_mask]++;
    }

    return ans;
}
class Solution {
    public long wonderfulSubstrings(String word) {
        long wonderfulCount = 0;
        int[] prefixMaskCounts = new int[1 << 10]; // Stores counts of each prefix mask
        int currentMask = 0; // Current prefix mask

        prefixMaskCounts[0] = 1; // Empty prefix has mask 0, occurs once

        for (char c : word.toCharArray()) {
            // Update current mask with the new character
            currentMask ^= (1 << (c - 'a'));

            // Case 1: All characters in the substring appear an even number of times.
            // This means currentMask ^ prevMask == 0, so prevMask == currentMask.
            wonderfulCount += prefixMaskCounts[currentMask];

            // Case 2: Exactly one character in the substring appears an odd number of times.
            // This means currentMask ^ prevMask has exactly one bit set.
            // So, prevMask == currentMask ^ (1 << k) for some k from 0 to 9.
            for (int i = 0; i < 10; i++) {
                wonderfulCount += prefixMaskCounts[currentMask ^ (1 << i)];
            }

            // Increment the count for the current prefix mask
            prefixMaskCounts[currentMask]++;
        }

        return wonderfulCount;
    }
}
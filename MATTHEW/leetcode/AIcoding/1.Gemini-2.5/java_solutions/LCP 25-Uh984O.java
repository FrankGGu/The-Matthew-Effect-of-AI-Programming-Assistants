class Solution {
    public long wonderfulSubstrings(String word) {
        long ans = 0;
        int mask = 0;
        int[] counts = new int[1 << 10]; // Stores frequency of each mask
        counts[0] = 1; // Represents the empty prefix, with all counts even (mask 0)

        for (char c : word.toCharArray()) {
            // Update the current prefix mask
            mask ^= (1 << (c - 'a'));

            // Case 1: Substring has all even counts (mask is 0)
            // This means current_mask ^ prefix_mask[j] == 0, so prefix_mask[j] == current_mask
            ans += counts[mask];

            // Case 2: Substring has exactly one character with an odd count (mask has 1 bit set)
            // This means current_mask ^ prefix_mask[j] == (1 << b) for some b
            // So prefix_mask[j] == current_mask ^ (1 << b)
            for (int i = 0; i < 10; i++) {
                ans += counts[mask ^ (1 << i)];
            }

            // Increment the count for the current mask
            counts[mask]++;
        }

        return ans;
    }
}
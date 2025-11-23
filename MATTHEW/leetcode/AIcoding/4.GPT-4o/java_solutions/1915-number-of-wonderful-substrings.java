class Solution {
    public long wonderfulSubstrings(String word) {
        long count = 0;
        int[] freq = new int[1024];
        freq[0] = 1;
        int mask = 0;

        for (char c : word.toCharArray()) {
            mask ^= 1 << (c - 'a');
            count += freq[mask];
            for (int i = 0; i < 10; i++) {
                count += freq[mask ^ (1 << i)];
            }
            freq[mask]++;
        }

        return count;
    }
}
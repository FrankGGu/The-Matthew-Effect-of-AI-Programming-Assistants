public class Solution {
    public int wonderfulSubstrings(String word) {
        int[] count = new int[1 << 10];
        count[0] = 1;
        int result = 0;
        int mask = 0;
        for (char c : word.toCharArray()) {
            mask ^= 1 << (c - 'a');
            for (int i = 0; i < 10; i++) {
                result += count[mask ^ (1 << i)];
            }
            result += count[mask];
            count[mask]++;
        }
        return result;
    }
}
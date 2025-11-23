class Solution {
    public int countPairs(int[] days) {
        int[] count = new int[7];
        for (int day : days) {
            count[day % 7]++;
        }

        int pairs = 0;
        pairs += count[0] * (count[0] - 1) / 2; // Pairs of days that are both on 0 mod 7
        for (int i = 1; i < 4; i++) {
            pairs += count[i] * count[7 - i];
        }
        pairs += count[3] * (count[3] - 1) / 2; // Pairs of days that are both on 3 mod 7

        return pairs;
    }
}
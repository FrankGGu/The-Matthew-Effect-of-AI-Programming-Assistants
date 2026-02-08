class Solution {
    public int countCompleteDayPairs(int[] hours) {
        int[] modCount = new int[24];
        int count = 0;
        for (int hour : hours) {
            int mod = hour % 24;
            int complement = (24 - mod) % 24;
            count += modCount[complement];
            modCount[mod]++;
        }
        return count;
    }
}
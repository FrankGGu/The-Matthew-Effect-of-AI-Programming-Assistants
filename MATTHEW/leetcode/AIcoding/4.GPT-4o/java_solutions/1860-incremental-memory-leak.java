class Solution {
    public int[] memLeak(int memory1, int memory2) {
        int day = 0;
        while (memory1 > day || memory2 > day) {
            day++;
            if (memory1 >= memory2) {
                memory1 -= day;
            } else {
                memory2 -= day;
            }
        }
        return new int[]{day, memory1, memory2};
    }
}
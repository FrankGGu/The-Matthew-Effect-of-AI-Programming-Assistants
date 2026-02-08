class Solution {
    public int minimumRounds(int[] tasks) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int task : tasks) {
            freq.put(task, freq.getOrDefault(task, 0) + 1);
        }

        int rounds = 0;
        for (int count : freq.values()) {
            if (count == 1) {
                return -1;
            }
            rounds += (count + 2) / 3;
        }
        return rounds;
    }
}
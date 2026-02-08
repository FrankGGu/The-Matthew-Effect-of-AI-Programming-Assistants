class Solution {
    public int numRabbits(int[] answers) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : answers) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }
        int res = 0;
        for (Map.Entry<Integer, Integer> entry : count.entrySet()) {
            int key = entry.getKey();
            int val = entry.getValue();
            res += (val + key) / (key + 1) * (key + 1);
        }
        return res;
    }
}
class Solution {
    public int[] findingUsersActiveMinutes(int[][] logs, int k) {
        Map<Integer, Set<Integer>> userActivity = new HashMap<>();
        for (int[] log : logs) {
            int userId = log[0];
            int minute = log[1];
            userActivity.computeIfAbsent(userId, key -> new HashSet<>()).add(minute);
        }

        int[] result = new int[k];
        for (Set<Integer> minutes : userActivity.values()) {
            int uam = minutes.size();
            if (uam <= k) {
                result[uam - 1]++;
            }
        }

        return result;
    }
}
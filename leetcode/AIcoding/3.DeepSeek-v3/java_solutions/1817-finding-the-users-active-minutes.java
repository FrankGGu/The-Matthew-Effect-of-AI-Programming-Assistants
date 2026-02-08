class Solution {
    public int[] findingUsersActiveMinutes(int[][] logs, int k) {
        Map<Integer, Set<Integer>> userToMinutes = new HashMap<>();
        for (int[] log : logs) {
            int userId = log[0];
            int minute = log[1];
            userToMinutes.putIfAbsent(userId, new HashSet<>());
            userToMinutes.get(userId).add(minute);
        }

        int[] result = new int[k];
        for (Set<Integer> minutes : userToMinutes.values()) {
            int uam = minutes.size();
            if (uam >= 1 && uam <= k) {
                result[uam - 1]++;
            }
        }
        return result;
    }
}
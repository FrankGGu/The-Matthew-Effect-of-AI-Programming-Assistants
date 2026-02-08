import java.util.HashMap;

public class Solution {
    private int mod = 1000000007;
    private HashMap<String, Long> memo;

    public int countRoutes(int[] locations, int start, int finish, int fuel) {
        memo = new HashMap<>();
        return (int) dfs(locations, start, finish, fuel);
    }

    private long dfs(int[] locations, int current, int finish, int fuel) {
        if (fuel < 0) return 0;
        if (current == finish) {
            long count = 1; 
            for (int i = 0; i < locations.length; i++) {
                if (i != current) {
                    count = (count + dfs(locations, i, finish, fuel - Math.abs(locations[current] - locations[i]))) % mod;
                }
            }
            return count;
        }
        String key = current + "," + fuel;
        if (memo.containsKey(key)) return memo.get(key);

        long count = 0;
        for (int i = 0; i < locations.length; i++) {
            if (i != current) {
                count = (count + dfs(locations, i, finish, fuel - Math.abs(locations[current] - locations[i]))) % mod;
            }
        }
        memo.put(key, count);
        return count;
    }
}
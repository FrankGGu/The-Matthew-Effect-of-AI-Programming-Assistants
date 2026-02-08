import java.util.HashSet;
import java.util.Set;

class Solution {
    public int maxCount(int[] banned, int n, int maxSum) {
        Set<Integer> bannedSet = new HashSet<>();
        for (int num : banned) {
            bannedSet.add(num);
        }
        int count = 0;
        int sum = 0;
        for (int i = 1; i <= n; i++) {
            if (!bannedSet.contains(i)) {
                if (sum + i <= maxSum) {
                    sum += i;
                    count++;
                } else {
                    break;
                }
            }
        }
        return count;
    }
}
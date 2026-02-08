import java.util.*;

class Solution {
    public int kthSmallest(int[] coins, int k) {
        Set<Integer> amounts = new HashSet<>();
        amounts.add(0);
        for (int coin : coins) {
            Set<Integer> newAmounts = new HashSet<>();
            for (int amount : amounts) {
                newAmounts.add(amount + coin);
            }
            amounts.addAll(newAmounts);
        }
        List<Integer> sortedAmounts = new ArrayList<>(amounts);
        Collections.sort(sortedAmounts);
        return sortedAmounts.size() >= k ? sortedAmounts.get(k - 1) : -1;
    }
}
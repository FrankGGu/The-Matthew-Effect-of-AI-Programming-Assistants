public class Solution {

import java.util.HashMap;
import java.util.Map;

public class ATM {
    private final int[] denominations;
    private final Map<Integer, Integer> balance;

    public ATM() {
        this.denominations = new int[]{100, 50, 20, 10, 5};
        this.balance = new HashMap<>();
        for (int den : denominations) {
            balance.put(den, 0);
        }
    }

    public void deposit(int[] banknotesCount) {
        for (int i = 0; i < denominations.length; i++) {
            balance.put(denominations[i], balance.get(denominations[i]) + banknotesCount[i]);
        }
    }

    public int[] withdraw(int amount) {
        int[] result = new int[denominations.length];
        for (int i = 0; i < denominations.length; i++) {
            int denomination = denominations[i];
            int count = amount / denomination;
            if (count > 0 && balance.get(denomination) >= count) {
                result[i] = count;
                amount -= count * denomination;
                balance.put(denomination, balance.get(denomination) - count);
            }
        }
        if (amount != 0) {
            for (int i = 0; i < denominations.length; i++) {
                balance.put(denominations[i], balance.get(denominations[i]) + result[i]);
            }
            return new int[]{-1};
        }
        return result;
    }
}
}
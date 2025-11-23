public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> oddEvenTransactions(List<List<Integer>> transactions) {
        List<List<Integer>> result = new ArrayList<>();
        for (List<Integer> transaction : transactions) {
            if (transaction.get(0) % 2 == 1) {
                result.add(transaction);
            }
        }
        return result;
    }
}
}
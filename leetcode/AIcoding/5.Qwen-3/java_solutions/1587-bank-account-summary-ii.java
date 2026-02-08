public class Solution {

import java.util.*;

public class BankAccountSummaryII {
    public static void main(String[] args) {
        // This is just for compilation purposes. LeetCode will handle the input.
    }

    public static List<List<String>> accountSummaryII(List<List<String>> accounts) {
        Map<String, Integer> emailToBalance = new HashMap<>();
        Map<String, String> emailToName = new HashMap<>();

        for (List<String> account : accounts) {
            String name = account.get(0);
            for (int i = 1; i < account.size(); i++) {
                String email = account.get(i);
                emailToName.put(email, name);
                emailToBalance.put(email, emailToBalance.getOrDefault(email, 0) + 1);
            }
        }

        List<List<String>> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : emailToBalance.entrySet()) {
            String email = entry.getKey();
            int balance = entry.getValue();
            if (balance > 1) {
                List<String> row = new ArrayList<>();
                row.add(emailToName.get(email));
                row.add(email);
                row.add(String.valueOf(balance));
                result.add(row);
            }
        }

        return result;
    }
}
}
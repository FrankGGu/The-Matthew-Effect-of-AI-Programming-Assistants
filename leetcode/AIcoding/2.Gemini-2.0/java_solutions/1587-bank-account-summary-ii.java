import java.util.HashMap;
import java.util.Map;

class Solution {
    public List<List<String>> accountSummary(List<List<String>> transactions) {
        Map<String, Long> balances = new HashMap<>();
        for (List<String> transaction : transactions) {
            String account = transaction.get(0);
            long amount = Long.parseLong(transaction.get(1));
            balances.put(account, balances.getOrDefault(account, 0L) + amount);
        }

        List<List<String>> result = new ArrayList<>();
        for (Map.Entry<String, Long> entry : balances.entrySet()) {
            if (entry.getValue() > 10000) {
                List<String> accountInfo = new ArrayList<>();
                accountInfo.add(entry.getKey());
                accountInfo.add(String.valueOf(entry.getValue()));
                result.add(accountInfo);
            }
        }

        result.sort((a, b) -> a.get(0).compareTo(b.get(0)));
        return result;
    }
}
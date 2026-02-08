import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Solution {
    public List<String> invalidTransactions(String[] transactions) {
        List<String> result = new ArrayList<>();
        Map<String, List<int[]>> map = new HashMap<>();

        for (int i = 0; i < transactions.length; i++) {
            String[] parts = transactions[i].split(",");
            String name = parts[0];
            int time = Integer.parseInt(parts[1]);
            int amount = Integer.parseInt(parts[2]);
            String city = parts[3];
            map.putIfAbsent(name, new ArrayList<>());
            map.get(name).add(new int[]{time, amount, i, city});
        }

        boolean[] invalid = new boolean[transactions.length];

        for (String name : map.keySet()) {
            List<int[]> list = map.get(name);
            for (int i = 0; i < list.size(); i++) {
                int[] t1 = list.get(i);
                if (t1[1] > 1000) {
                    invalid[t1[2]] = true;
                }
                for (int j = 0; j < list.size(); j++) {
                    if (i != j) {
                        int[] t2 = list.get(j);
                        if (!t1[3].equals(t2[3]) && Math.abs(t1[0] - t2[0]) <= 60) {
                            invalid[t1[2]] = true;
                            invalid[t2[2]] = true;
                        }
                    }
                }
            }
        }

        for (int i = 0; i < invalid.length; i++) {
            if (invalid[i]) {
                result.add(transactions[i]);
            }
        }

        return result;
    }
}
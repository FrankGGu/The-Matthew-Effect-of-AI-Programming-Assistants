public class Solution {

import java.util.*;

public class SeasonalSalesAnalysis {
    public List<List<String>> findSeasonalSales(List<List<String>> sales) {
        Map<String, Integer> seasonMap = new HashMap<>();
        seasonMap.put("Winter", 0);
        seasonMap.put("Spring", 1);
        seasonMap.put("Summer", 2);
        seasonMap.put("Autumn", 3);

        List<List<String>> result = new ArrayList<>();

        for (List<String> sale : sales) {
            String product = sale.get(0);
            String season = sale.get(1);
            int quantity = Integer.parseInt(sale.get(2));

            if (seasonMap.containsKey(season)) {
                List<String> entry = new ArrayList<>();
                entry.add(product);
                entry.add(season);
                entry.add(String.valueOf(quantity));
                result.add(entry);
            }
        }

        result.sort((a, b) -> {
            int cmp = Integer.compare(seasonMap.get(a.get(1)), seasonMap.get(b.get(1)));
            if (cmp != 0) return cmp;
            return a.get(0).compareTo(b.get(0));
        });

        return result;
    }
}
}
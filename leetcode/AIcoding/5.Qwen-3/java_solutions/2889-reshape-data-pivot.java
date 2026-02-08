public class Solution {

import java.util.*;

public class Solution {
    public static List<List<String>> pivotTable(List<List<String>> users) {
        Map<String, Map<String, Integer>> map = new HashMap<>();

        for (List<String> user : users) {
            String name = user.get(0);
            String country = user.get(1);
            String city = user.get(2);

            map.putIfAbsent(country, new HashMap<>());
            map.get(country).put(city, map.get(country).getOrDefault(city, 0) + 1);
        }

        List<List<String>> result = new ArrayList<>();
        Set<String> countries = map.keySet();
        Set<String> cities = new HashSet<>();

        for (Map<String, Integer> cityMap : map.values()) {
            cities.addAll(cityMap.keySet());
        }

        List<String> header = new ArrayList<>();
        header.add("country");
        header.addAll(new ArrayList<>(cities));
        result.add(header);

        for (String country : countries) {
            List<String> row = new ArrayList<>();
            row.add(country);
            for (String city : cities) {
                row.add(String.valueOf(map.get(country).getOrDefault(city, 0)));
            }
            result.add(row);
        }

        return result;
    }
}
}
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

class Solution {
    public String destCity(List<List<String>> paths) {
        Set<String> startCities = new HashSet<>();
        Set<String> endCities = new HashSet<>();

        for (List<String> path : paths) {
            startCities.add(path.get(0));
            endCities.add(path.get(1));
        }

        for (String city : endCities) {
            if (!startCities.contains(city)) {
                return city;
            }
        }

        return "";
    }
}
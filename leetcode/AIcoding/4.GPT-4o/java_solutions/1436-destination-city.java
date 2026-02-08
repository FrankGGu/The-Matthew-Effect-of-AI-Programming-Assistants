import java.util.HashSet;
import java.util.List;

public class Solution {
    public String destCity(List<List<String>> paths) {
        HashSet<String> startCities = new HashSet<>();
        for (List<String> path : paths) {
            startCities.add(path.get(0));
        }
        for (List<String> path : paths) {
            if (!startCities.contains(path.get(1))) {
                return path.get(1);
            }
        }
        return "";
    }
}
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<String> subdomainVisits(String[] cpdomains) {
        Map<String, Integer> counts = new HashMap<>();
        for (String cpdomain : cpdomains) {
            String[] parts = cpdomain.split(" ");
            int count = Integer.parseInt(parts[0]);
            String domain = parts[1];
            String[] subdomains = domain.split("\\.");
            String currentDomain = "";
            for (int i = subdomains.length - 1; i >= 0; i--) {
                if (i == subdomains.length - 1) {
                    currentDomain = subdomains[i];
                } else {
                    currentDomain = subdomains[i] + "." + currentDomain;
                }
                counts.put(currentDomain, counts.getOrDefault(currentDomain, 0) + count);
            }
        }
        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : counts.entrySet()) {
            result.add(entry.getValue() + " " + entry.getKey());
        }
        return result;
    }
}
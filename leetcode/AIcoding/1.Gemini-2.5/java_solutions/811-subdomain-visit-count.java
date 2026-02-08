import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<String> subdomainVisits(String[] cpdomains) {
        Map<String, Integer> counts = new HashMap<>();

        for (String cpdomain : cpdomains) {
            int spaceIndex = cpdomain.indexOf(' ');
            int count = Integer.parseInt(cpdomain.substring(0, spaceIndex));
            String domain = cpdomain.substring(spaceIndex + 1);

            String currentDomain = domain;
            while (true) {
                counts.put(currentDomain, counts.getOrDefault(currentDomain, 0) + count);

                int dotIndex = currentDomain.indexOf('.');
                if (dotIndex == -1) {
                    break;
                }
                currentDomain = currentDomain.substring(dotIndex + 1);
            }
        }

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : counts.entrySet()) {
            result.add(entry.getValue() + " " + entry.getKey());
        }

        return result;
    }
}
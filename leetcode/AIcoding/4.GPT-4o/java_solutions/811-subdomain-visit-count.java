import java.util.*;

class Solution {
    public List<String> subdomainVisits(String[] cpdomains) {
        Map<String, Integer> countMap = new HashMap<>();

        for (String cpdomain : cpdomains) {
            String[] parts = cpdomain.split(" ");
            int count = Integer.parseInt(parts[0]);
            String domain = parts[1];

            String[] subdomains = domain.split("\\.");
            StringBuilder subdomain = new StringBuilder();

            for (int i = subdomains.length - 1; i >= 0; i--) {
                if (i < subdomains.length - 1) {
                    subdomain.insert(0, ".");
                }
                subdomain.insert(0, subdomains[i]);
                countMap.put(subdomain.toString(), countMap.getOrDefault(subdomain.toString(), 0) + count);
            }
        }

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : countMap.entrySet()) {
            result.add(entry.getValue() + " " + entry.getKey());
        }

        return result;
    }
}
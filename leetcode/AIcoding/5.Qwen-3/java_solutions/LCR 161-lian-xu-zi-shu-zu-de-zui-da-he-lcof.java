public class Solution {

import java.util.*;

public class Solution {
    public List<String> subdomainVisits(String[] cpdomains) {
        Map<String, Integer> domainMap = new HashMap<>();
        for (String domain : cpdomains) {
            String[] parts = domain.split(" ");
            int count = Integer.parseInt(parts[0]);
            String[] subdomains = parts[1].split("\\.");
            for (int i = 0; i < subdomains.length; i++) {
                StringBuilder sb = new StringBuilder();
                for (int j = i; j < subdomains.length; j++) {
                    sb.append(subdomains[j]);
                    if (j != subdomains.length - 1) {
                        sb.append(".");
                    }
                }
                String currentDomain = sb.toString();
                domainMap.put(currentDomain, domainMap.getOrDefault(currentDomain, 0) + count);
            }
        }
        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : domainMap.entrySet()) {
            result.add(entry.getValue() + " " + entry.getKey());
        }
        return result;
    }
}
}
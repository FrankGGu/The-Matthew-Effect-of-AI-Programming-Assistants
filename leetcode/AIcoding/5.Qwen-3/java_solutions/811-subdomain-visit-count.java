public class Solution {

import java.util.*;

public class Solution {
    public List<String> subdomainVisits(String[] cpdomains) {
        Map<String, Integer> domainMap = new HashMap<>();
        for (String cpdomain : cpdomains) {
            String[] parts = cpdomain.split(" ");
            int count = Integer.parseInt(parts[0]);
            String domain = parts[1];
            String[] subDomains = domain.split("\\.");
            for (int i = 0; i < subDomains.length; i++) {
                StringBuilder sb = new StringBuilder();
                for (int j = i; j < subDomains.length; j++) {
                    sb.append(subDomains[j]);
                    if (j != subDomains.length - 1) {
                        sb.append(".");
                    }
                }
                String subDomain = sb.toString();
                domainMap.put(subDomain, domainMap.getOrDefault(subDomain, 0) + count);
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
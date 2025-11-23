import java.util.HashSet;
import java.util.Set;

class Solution {
    public int numUniqueEmails(String[] emails) {
        Set<String> uniqueEmails = new HashSet<>();

        for (String email : emails) {
            StringBuilder canonicalEmail = new StringBuilder();
            int atIndex = email.indexOf('@');
            String localName = email.substring(0, atIndex);
            String domainName = email.substring(atIndex); // includes '@'

            for (char c : localName.toCharArray()) {
                if (c == '.') {
                    continue;
                }
                if (c == '+') {
                    break;
                }
                canonicalEmail.append(c);
            }
            canonicalEmail.append(domainName);
            uniqueEmails.add(canonicalEmail.toString());
        }

        return uniqueEmails.size();
    }
}
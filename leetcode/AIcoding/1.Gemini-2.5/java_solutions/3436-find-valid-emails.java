import java.util.HashSet;
import java.util.Set;

class Solution {
    public int numUniqueEmails(String[] emails) {
        Set<String> uniqueEmails = new HashSet<>();

        for (String email : emails) {
            StringBuilder normalizedEmail = new StringBuilder();
            int atIndex = email.indexOf('@');
            String localPart = email.substring(0, atIndex);
            String domainPart = email.substring(atIndex); // includes '@' and domain

            for (char c : localPart.toCharArray()) {
                if (c == '.') {
                    // Ignore '.'
                } else if (c == '+') {
                    break; // Ignore everything after '+'
                } else {
                    normalizedEmail.append(c);
                }
            }
            normalizedEmail.append(domainPart);
            uniqueEmails.add(normalizedEmail.toString());
        }

        return uniqueEmails.size();
    }
}
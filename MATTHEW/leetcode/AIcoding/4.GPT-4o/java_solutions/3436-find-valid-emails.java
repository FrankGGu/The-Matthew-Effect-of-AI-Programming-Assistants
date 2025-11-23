import java.util.*;

class Solution {
    public List<String> filterEmails(String[] emails) {
        Set<String> validEmails = new HashSet<>();
        String regex = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}";

        for (String email : emails) {
            if (email.matches(regex)) {
                validEmails.add(email.toLowerCase());
            }
        }

        return new ArrayList<>(validEmails);
    }
}
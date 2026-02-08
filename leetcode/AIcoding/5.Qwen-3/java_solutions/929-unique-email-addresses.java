public class Solution {

import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int numUniqueEmails(String[] emails) {
        Set<String> uniqueEmails = new HashSet<>();
        for (String email : emails) {
            String[] parts = email.split("@");
            String local = parts[0].split("\\+")[0].replace(".", "");
            String domain = parts[1];
            uniqueEmails.add(local + "@" + domain);
        }
        return uniqueEmails.size();
    }
}
}
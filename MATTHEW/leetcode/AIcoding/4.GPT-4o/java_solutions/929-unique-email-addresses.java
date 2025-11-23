import java.util.HashSet;

public class Solution {
    public int numUniqueEmails(String[] emails) {
        HashSet<String> uniqueEmails = new HashSet<>();

        for (String email : emails) {
            String[] parts = email.split("@");
            String local = parts[0].replace(".", "");
            int plusIndex = local.indexOf('+');
            if (plusIndex != -1) {
                local = local.substring(0, plusIndex);
            }
            String uniqueEmail = local + "@" + parts[1];
            uniqueEmails.add(uniqueEmail);
        }

        return uniqueEmails.size();
    }
}
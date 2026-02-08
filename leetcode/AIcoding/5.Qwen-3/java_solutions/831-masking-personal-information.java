public class Solution {
    public String maskPII(String email) {
        String[] parts = email.split("@");
        String local = parts[0];
        String domain = parts[1];
        StringBuilder masked = new StringBuilder();
        masked.append(local.charAt(0)).append("*****").append(local.charAt(local.length() - 1));
        masked.append("@").append(domain);
        return masked.toString();
    }
}
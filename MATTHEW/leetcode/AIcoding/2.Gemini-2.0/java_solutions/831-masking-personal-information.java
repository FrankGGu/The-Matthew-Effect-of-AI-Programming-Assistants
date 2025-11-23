class Solution {
    public String maskPII(String s) {
        if (s.contains("@")) {
            String[] parts = s.toLowerCase().split("@");
            String name = parts[0];
            String domain = parts[1];
            return name.charAt(0) + "*****" + name.charAt(name.length() - 1) + "@" + domain;
        } else {
            String digits = s.replaceAll("[^0-9]", "");
            String lastFour = digits.substring(digits.length() - 4);
            String masked = "***-***-" + lastFour;
            if (digits.length() > 10) {
                int plusCount = digits.length() - 10;
                StringBuilder sb = new StringBuilder();
                sb.append("+");
                for (int i = 0; i < plusCount; i++) {
                    sb.append("*");
                }
                sb.append("-");
                return sb.toString() + masked;
            } else {
                return masked;
            }
        }
    }
}
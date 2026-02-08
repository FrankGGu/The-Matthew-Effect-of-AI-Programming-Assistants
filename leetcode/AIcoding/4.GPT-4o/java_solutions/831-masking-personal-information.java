class Solution {
    public String maskPII(String s) {
        s = s.toLowerCase();
        if (s.contains("@")) {
            String[] parts = s.split("@");
            String name = parts[0];
            String domain = parts[1];
            String maskedName = name.charAt(0) + "*****" + name.charAt(name.length() - 1);
            return maskedName + "@" + domain;
        } else {
            s = s.replaceAll("[^0-9]", "");
            if (s.length() == 10) {
                return "***-***-" + s.substring(6);
            } else {
                return "+***-***-***-" + s.substring(s.length() - 4);
            }
        }
    }
}
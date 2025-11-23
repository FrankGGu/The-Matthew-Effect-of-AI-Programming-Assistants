class Solution {
    public String maskPII(String s) {
        if (s.contains("@")) {
            return maskEmail(s);
        } else {
            return maskPhone(s);
        }
    }

    private String maskEmail(String s) {
        s = s.toLowerCase();
        int atIndex = s.indexOf('@');
        String name = s.substring(0, atIndex);
        String domain = s.substring(atIndex);
        StringBuilder masked = new StringBuilder();
        masked.append(name.charAt(0));
        masked.append("*****");
        masked.append(name.charAt(name.length() - 1));
        masked.append(domain);
        return masked.toString();
    }

    private String maskPhone(String s) {
        StringBuilder digits = new StringBuilder();
        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                digits.append(c);
            }
        }
        int n = digits.length();
        StringBuilder masked = new StringBuilder();
        if (n > 10) {
            masked.append('+');
            for (int i = 0; i < n - 10; i++) {
                masked.append('*');
            }
            masked.append('-');
        }
        masked.append("***-***-");
        masked.append(digits.substring(n - 4));
        return masked.toString();
    }
}
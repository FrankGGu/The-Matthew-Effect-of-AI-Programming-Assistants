class Solution {
    public String maskPII(String s) {
        int atIndex = s.indexOf('@');
        if (atIndex != -1) {
            // Email
            StringBuilder maskedEmail = new StringBuilder();
            maskedEmail.append(Character.toLowerCase(s.charAt(0)));
            maskedEmail.append("*****");
            maskedEmail.append(Character.toLowerCase(s.charAt(atIndex - 1)));
            maskedEmail.append(s.substring(atIndex).toLowerCase());
            return maskedEmail.toString();
        } else {
            // Phone Number
            StringBuilder digits = new StringBuilder();
            for (char c : s.toCharArray()) {
                if (Character.isDigit(c)) {
                    digits.append(c);
                }
            }

            int n = digits.length();
            StringBuilder maskedPhone = new StringBuilder();

            if (n == 10) {
                maskedPhone.append("***-***-");
                maskedPhone.append(digits.substring(6));
            } else if (n == 11) {
                maskedPhone.append("+*-***-***-");
                maskedPhone.append(digits.substring(7));
            } else if (n == 12) {
                maskedPhone.append("+**-***-***-");
                maskedPhone.append(digits.substring(8));
            } else { // n == 13
                maskedPhone.append("+***-***-***-");
                maskedPhone.append(digits.substring(9));
            }
            return maskedPhone.toString();
        }
    }
}
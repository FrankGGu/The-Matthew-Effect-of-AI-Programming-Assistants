class Solution {
    public String validIPAddress(String IP) {
        if (IP.contains(".")) {
            // Potentially IPv4
            String[] parts = IP.split("\\.", -1);
            if (parts.length != 4) {
                return "Neither";
            }
            for (String part : parts) {
                if (part.length() == 0 || part.length() > 3) {
                    return "Neither";
                }
                if (part.length() > 1 && part.charAt(0) == '0') {
                    return "Neither";
                }
                int num;
                try {
                    num = Integer.parseInt(part);
                } catch (NumberFormatException e) {
                    return "Neither";
                }
                if (num < 0 || num > 255) {
                    return "Neither";
                }
            }
            return "IPv4";
        } else if (IP.contains(":")) {
            // Potentially IPv6
            String[] parts = IP.split(":", -1);
            if (parts.length != 8) {
                return "Neither";
            }
            for (String part : parts) {
                if (part.length() == 0 || part.length() > 4) {
                    return "Neither";
                }
                for (char c : part.toCharArray()) {
                    if (!((c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'))) {
                        return "Neither";
                    }
                }
            }
            return "IPv6";
        } else {
            // Neither '.' nor ':' found
            return "Neither";
        }
    }
}
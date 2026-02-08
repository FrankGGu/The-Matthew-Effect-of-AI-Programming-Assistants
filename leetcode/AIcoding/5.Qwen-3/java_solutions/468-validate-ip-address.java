public class Solution {
    public String validIPAddress(String IP) {
        if (IP == null || IP.length() == 0) {
            return "Neither";
        }
        if (IP.contains(".")) {
            return validateIPv4(IP);
        } else if (IP.contains(":")) {
            return validateIPv6(IP);
        } else {
            return "Neither";
        }
    }

    private String validateIPv4(String IP) {
        String[] parts = IP.split("\\.");
        if (parts.length != 4) {
            return "Neither";
        }
        for (String part : parts) {
            if (part.length() == 0 || part.length() > 3) {
                return "Neither";
            }
            if (part.charAt(0) == '0' && part.length() > 1) {
                return "Neither";
            }
            for (char c : part.toCharArray()) {
                if (!Character.isDigit(c)) {
                    return "Neither";
                }
            }
            int num = Integer.parseInt(part);
            if (num < 0 || num > 255) {
                return "Neither";
            }
        }
        return "IPv4";
    }

    private String validateIPv6(String IP) {
        String[] parts = IP.split(":");
        if (parts.length != 8) {
            return "Neither";
        }
        for (String part : parts) {
            if (part.length() < 1 || part.length() > 4) {
                return "Neither";
            }
            for (char c : part.toCharArray()) {
                if (!(c >= '0' && c <= '9') && !(c >= 'a' && c <= 'f') && !(c >= 'A' && c <= 'F')) {
                    return "Neither";
                }
            }
        }
        return "IPv6";
    }
}
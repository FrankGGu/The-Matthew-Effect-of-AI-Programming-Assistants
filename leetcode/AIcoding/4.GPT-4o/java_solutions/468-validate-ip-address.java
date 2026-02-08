public class Solution {
    public String validIPAddress(String IP) {
        if (IP.contains(".")) {
            return isValidIPv4(IP) ? "IPv4" : "Neither";
        } else if (IP.contains(":")) {
            return isValidIPv6(IP) ? "IPv6" : "Neither";
        }
        return "Neither";
    }

    private boolean isValidIPv4(String IP) {
        String[] parts = IP.split("\\.");
        if (parts.length != 4) return false;
        for (String part : parts) {
            if (part.length() == 0 || part.length() > 3 || (part.charAt(0) == '0' && part.length() > 1) || !part.matches("\\d+")) {
                return false;
            }
            int num = Integer.parseInt(part);
            if (num < 0 || num > 255) return false;
        }
        return true;
    }

    private boolean isValidIPv6(String IP) {
        String[] parts = IP.split(":");
        if (parts.length != 8) return false;
        for (String part : parts) {
            if (part.length() == 0 || part.length() > 4 || !part.matches("[0-9a-fA-F]+")) {
                return false;
            }
        }
        return true;
    }
}
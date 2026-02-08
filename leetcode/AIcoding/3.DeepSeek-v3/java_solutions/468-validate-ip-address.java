class Solution {
    public String validIPAddress(String IP) {
        if (isIPv4(IP)) {
            return "IPv4";
        } else if (isIPv6(IP)) {
            return "IPv6";
        } else {
            return "Neither";
        }
    }

    private boolean isIPv4(String IP) {
        String[] parts = IP.split("\\.", -1);
        if (parts.length != 4) return false;
        for (String part : parts) {
            if (part.length() == 0 || part.length() > 3) return false;
            if (part.charAt(0) == '0' && part.length() != 1) return false;
            try {
                int num = Integer.parseInt(part);
                if (num < 0 || num > 255) return false;
            } catch (NumberFormatException e) {
                return false;
            }
        }
        return true;
    }

    private boolean isIPv6(String IP) {
        String[] parts = IP.split(":", -1);
        if (parts.length != 8) return false;
        for (String part : parts) {
            if (part.length() == 0 || part.length() > 4) return false;
            for (char c : part.toCharArray()) {
                if (!((c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'))) {
                    return false;
                }
            }
        }
        return true;
    }
}
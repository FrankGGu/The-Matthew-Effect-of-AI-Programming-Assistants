class Solution {
    public String validIPAddress(String IP) {
        if (IP.indexOf('.') >= 0) {
            return validateIPv4(IP);
        } else if (IP.indexOf(':') >= 0) {
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
            if (part.length() > 1 && part.charAt(0) == '0') {
                return "Neither";
            }
            try {
                int num = Integer.parseInt(part);
                if (num < 0 || num > 255) {
                    return "Neither";
                }
                if (!part.equals(Integer.toString(num))) {
                    return "Neither";
                }
            } catch (NumberFormatException e) {
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
            if (part.length() == 0 || part.length() > 4) {
                return "Neither";
            }
            try {
                int num = Integer.parseInt(part, 16);
                if (num < 0 || num > 65535) {
                    return "Neither";
                }
                for (char c : part.toCharArray()) {
                    if (!Character.isDigit(c) && !(c >= 'a' && c <= 'f') && !(c >= 'A' && c <= 'F')) {
                        return "Neither";
                    }
                }
            } catch (NumberFormatException e) {
                return "Neither";
            }
        }

        return "IPv6";
    }
}
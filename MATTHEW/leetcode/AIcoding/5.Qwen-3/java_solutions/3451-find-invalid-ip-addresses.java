public class Solution {

import java.util.List;
import java.util.ArrayList;

public class Solution {
    public List<String> invalidIPAddresses(List<String> addresses) {
        List<String> result = new ArrayList<>();
        for (String ip : addresses) {
            if (!isValid(ip)) {
                result.add(ip);
            }
        }
        return result;
    }

    private boolean isValid(String ip) {
        String[] parts = ip.split("\\.");
        if (parts.length != 4) {
            return false;
        }
        for (String part : parts) {
            if (part.length() == 0 || part.length() > 3) {
                return false;
            }
            if (part.charAt(0) == '0' && part.length() > 1) {
                return false;
            }
            if (!part.matches("\\d+")) {
                return false;
            }
            int num = Integer.parseInt(part);
            if (num < 0 || num > 255) {
                return false;
            }
        }
        return true;
    }
}
}
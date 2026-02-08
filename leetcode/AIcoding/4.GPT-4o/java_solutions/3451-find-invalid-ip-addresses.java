import java.util.*;

public class Solution {
    public List<String> invalidIPAddresses(String s) {
        Set<String> invalidIPs = new HashSet<>();
        backtrack(s, 0, new StringBuilder(), 0, invalidIPs);
        return new ArrayList<>(invalidIPs);
    }

    private void backtrack(String s, int start, StringBuilder currentIP, int octetCount, Set<String> invalidIPs) {
        if (octetCount == 4) {
            if (start == s.length()) {
                return;
            }
            invalidIPs.add(currentIP.toString());
            return;
        }

        for (int length = 1; length <= 3; length++) {
            if (start + length > s.length()) break;

            String octet = s.substring(start, start + length);
            if (isValid(octet)) {
                int currentLength = currentIP.length();
                if (octetCount > 0) {
                    currentIP.append(".");
                }
                currentIP.append(octet);
                backtrack(s, start + length, currentIP, octetCount + 1, invalidIPs);
                currentIP.setLength(currentLength);
            }
        }
    }

    private boolean isValid(String octet) {
        if (octet.length() == 0 || octet.length() > 3) return false;
        if (octet.charAt(0) == '0' && octet.length() > 1) return false;
        int num = Integer.parseInt(octet);
        return num >= 0 && num <= 255;
    }
}
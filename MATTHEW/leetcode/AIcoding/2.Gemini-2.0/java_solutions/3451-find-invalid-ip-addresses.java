import java.util.*;

class Solution {
    public List<String> restoreIpAddresses(String s) {
        List<String> result = new ArrayList<>();
        if (s == null || s.length() < 4 || s.length() > 12) {
            return result;
        }
        restoreIpAddressesHelper(s, 0, 0, "", result);
        return result;
    }

    private void restoreIpAddressesHelper(String s, int index, int count, String currentIp, List<String> result) {
        if (count == 4) {
            if (index == s.length()) {
                result.add(currentIp.substring(0, currentIp.length() - 1));
            }
            return;
        }

        for (int i = 1; i <= 3; i++) {
            if (index + i > s.length()) {
                break;
            }
            String segment = s.substring(index, index + i);
            if (isValid(segment)) {
                restoreIpAddressesHelper(s, index + i, count + 1, currentIp + segment + ".", result);
            }
        }
    }

    private boolean isValid(String segment) {
        if (segment.startsWith("0") && segment.length() > 1) {
            return false;
        }
        int num = Integer.parseInt(segment);
        return num >= 0 && num <= 255;
    }
}
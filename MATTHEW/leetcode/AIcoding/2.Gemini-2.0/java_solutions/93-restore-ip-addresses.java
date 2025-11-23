import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> restoreIpAddresses(String s) {
        List<String> result = new ArrayList<>();
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

        for (int i = 1; i <= 3 && index + i <= s.length(); i++) {
            String part = s.substring(index, index + i);
            if (isValidPart(part)) {
                restoreIpAddressesHelper(s, index + i, count + 1, currentIp + part + ".", result);
            }
        }
    }

    private boolean isValidPart(String part) {
        if (part.length() > 1 && part.startsWith("0")) {
            return false;
        }
        int num = Integer.parseInt(part);
        return num >= 0 && num <= 255;
    }
}
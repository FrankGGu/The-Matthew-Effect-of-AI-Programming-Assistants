import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> restoreIpAddresses(String s) {
        List<String> result = new ArrayList<>();
        if (s == null || s.length() < 4 || s.length() > 12) {
            return result;
        }
        restoreIpAddressesHelper(s, 0, 0, new ArrayList<>(), result);
        return result;
    }

    private void restoreIpAddressesHelper(String s, int index, int segment, List<String> current, List<String> result) {
        if (segment == 4) {
            if (index == s.length()) {
                result.add(String.join(".", current));
            }
            return;
        }

        for (int i = 1; i <= 3; i++) {
            if (index + i > s.length()) {
                break;
            }
            String sub = s.substring(index, index + i);
            if (isValid(sub)) {
                current.add(sub);
                restoreIpAddressesHelper(s, index + i, segment + 1, current, result);
                current.remove(current.size() - 1);
            }
        }
    }

    private boolean isValid(String s) {
        if (s.length() > 1 && s.startsWith("0")) {
            return false;
        }
        int num = Integer.parseInt(s);
        return num >= 0 && num <= 255;
    }
}
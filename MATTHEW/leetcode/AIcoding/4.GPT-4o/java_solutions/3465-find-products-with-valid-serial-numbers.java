import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int countProducts(String[] serials) {
        Set<String> validSerials = new HashSet<>();
        for (String serial : serials) {
            if (isValid(serial)) {
                validSerials.add(serial);
            }
        }
        return validSerials.size();
    }

    private boolean isValid(String serial) {
        if (serial.length() != 10) return false;
        for (int i = 0; i < serial.length(); i++) {
            char c = serial.charAt(i);
            if (!(Character.isDigit(c) || Character.isUpperCase(c))) {
                return false;
            }
        }
        return true;
    }
}
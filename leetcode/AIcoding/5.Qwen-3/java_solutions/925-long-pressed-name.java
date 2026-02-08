public class Solution {

class Solution {
    public boolean isLongPressedName(String name, String typed) {
        int i = 0, j = 0;
        while (i < name.length() && j < typed.length()) {
            if (name.charAt(i) != typed.charAt(j)) {
                return false;
            }
            int countName = 0, countTyped = 0;
            char current = name.charAt(i);
            while (i < name.length() && name.charAt(i) == current) {
                i++;
                countName++;
            }
            while (j < typed.length() && typed.charAt(j) == current) {
                j++;
                countTyped++;
            }
            if (countTyped < countName) {
                return false;
            }
        }
        return i == name.length() && j == typed.length();
    }
}
}
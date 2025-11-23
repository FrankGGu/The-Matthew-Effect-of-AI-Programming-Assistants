class Solution {
    public boolean exist(String s1, String s2) {
        if (s1 == null || s2 == null || s1.length() == 0 || s2.length() == 0) {
            return false;
        }

        if (s1.length() > s2.length()) {
            return false;
        }

        if (s2.contains(s1)) {
            return true;
        }

        StringBuilder sb = new StringBuilder(s1);
        String reversedS1 = sb.reverse().toString();

        return s2.contains(reversedS1);
    }
}
class Solution {
    public boolean areAlmostEqual(String s1, String s2) {
        if (s1.equals(s2)) return true;
        int count = 0;
        char[] a = new char[2];
        char[] b = new char[2];

        for (int i = 0; i < s1.length(); i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                if (count == 2) return false;
                a[count] = s1.charAt(i);
                b[count] = s2.charAt(i);
                count++;
            }
        }
        return count == 2 && a[0] == b[1] && a[1] == b[0];
    }
}
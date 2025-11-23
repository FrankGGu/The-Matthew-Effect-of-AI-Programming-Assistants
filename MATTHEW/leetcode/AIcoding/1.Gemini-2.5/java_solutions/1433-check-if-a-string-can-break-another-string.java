import java.util.Arrays;

class Solution {
    public boolean checkIfCanBreak(String s1, String s2) {
        char[] c1 = s1.toCharArray();
        char[] c2 = s2.toCharArray();

        Arrays.sort(c1);
        Arrays.sort(c2);

        return canBreak(c1, c2) || canBreak(c2, c1);
    }

    private boolean canBreak(char[] arr1, char[] arr2) {
        for (int i = 0; i < arr1.length; i++) {
            if (arr1[i] < arr2[i]) {
                return false;
            }
        }
        return true;
    }
}
import java.util.Arrays;

class Solution {
    public boolean checkStrings(String s1, String s2) {
        int n = s1.length();

        char[] s1EvenChars = new char[(n + 1) / 2];
        char[] s2EvenChars = new char[(n + 1) / 2];
        int evenCount = 0;
        for (int i = 0; i < n; i += 2) {
            s1EvenChars[evenCount] = s1.charAt(i);
            s2EvenChars[evenCount] = s2.charAt(i);
            evenCount++;
        }

        char[] s1OddChars = new char[n / 2];
        char[] s2OddChars = new char[n / 2];
        int oddCount = 0;
        for (int i = 1; i < n; i += 2) {
            s1OddChars[oddCount] = s1.charAt(i);
            s2OddChars[oddCount] = s2.charAt(i);
            oddCount++;
        }

        Arrays.sort(s1EvenChars);
        Arrays.sort(s2EvenChars);
        if (!Arrays.equals(s1EvenChars, s2EvenChars)) {
            return false;
        }

        Arrays.sort(s1OddChars);
        Arrays.sort(s2OddChars);
        if (!Arrays.equals(s1OddChars, s2OddChars)) {
            return false;
        }

        return true;
    }
}
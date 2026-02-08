import java.util.Arrays;

class Solution {
    public boolean checkStrings(String s1, String s2) {
        int n = s1.length();
        char[] odd1 = new char[(n + 1) / 2];
        char[] even1 = new char[n / 2];
        char[] odd2 = new char[(n + 1) / 2];
        char[] even2 = new char[n / 2];

        int oddIdx = 0;
        int evenIdx = 0;
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                odd1[oddIdx++] = s1.charAt(i);
                odd2[oddIdx - 1] = s2.charAt(i);
            } else {
                even1[evenIdx++] = s1.charAt(i);
                even2[evenIdx - 1] = s2.charAt(i);
            }
        }

        Arrays.sort(odd1);
        Arrays.sort(odd2);
        Arrays.sort(even1);
        Arrays.sort(even2);

        return Arrays.equals(odd1, odd2) && Arrays.equals(even1, even2);
    }
}
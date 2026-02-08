class Solution {
    public boolean checkInclusion(String s1, String s2) {
        int n1 = s1.length();
        int n2 = s2.length();

        if (n1 > n2) {
            return false;
        }

        int[] s1Freq = new int[26];
        int[] windowFreq = new int[26];

        for (int i = 0; i < n1; i++) {
            s1Freq[s1.charAt(i) - 'a']++;
            windowFreq[s2.charAt(i) - 'a']++;
        }

        if (matches(s1Freq, windowFreq)) {
            return true;
        }

        for (int i = n1; i < n2; i++) {
            windowFreq[s2.charAt(i) - 'a']++;
            windowFreq[s2.charAt(i - n1) - 'a']--;

            if (matches(s1Freq, windowFreq)) {
                return true;
            }
        }

        return false;
    }

    private boolean matches(int[] arr1, int[] arr2) {
        for (int i = 0; i < 26; i++) {
            if (arr1[i] != arr2[i]) {
                return false;
            }
        }
        return true;
    }
}
import java.util.Arrays;

class Solution {
    public int minAnagramLength(String s) {
        int n = s.length();

        for (int k = 1; k <= n; k++) {
            if (n % k == 0) {
                int[] firstFreq = new int[26];
                for (int i = 0; i < k; i++) {
                    firstFreq[s.charAt(i) - 'a']++;
                }

                boolean possible = true;
                for (int i = k; i < n; i += k) {
                    int[] currentFreq = new int[26];
                    for (int j = 0; j < k; j++) {
                        currentFreq[s.charAt(i + j) - 'a']++;
                    }

                    if (!Arrays.equals(firstFreq, currentFreq)) {
                        possible = false;
                        break;
                    }
                }

                if (possible) {
                    return k;
                }
            }
        }
        return n; 
    }
}
class Solution {
    public int minimumTimeToRevert(String word, int c) {
        int n = word.length();

        int[] Z = new int[n];
        Z[0] = n; 

        int L = 0, R = 0; 
        for (int i = 1; i < n; ++i) {
            if (i > R) { 
                L = R = i; 
                while (R < n && word.charAt(R - L) == word.charAt(R)) {
                    R++;
                }
                Z[i] = R - L;
                R--; 
            } else { 
                int k = i - L; 
                if (Z[k] < R - i + 1) { 
                    Z[i] = Z[k];
                } else { 
                    L = i; 
                    while (R < n && word.charAt(R - L) == word.charAt(R)) {
                        R++;
                    }
                    Z[i] = R - L;
                    R--; 
                }
            }
        }

        for (int t = 1; ; ++t) { 
            int k = t * c; 

            if (k >= n) {
                return t;
            }

            if (Z[k] == n - k) {
                return t;
            }
        }
    }
}
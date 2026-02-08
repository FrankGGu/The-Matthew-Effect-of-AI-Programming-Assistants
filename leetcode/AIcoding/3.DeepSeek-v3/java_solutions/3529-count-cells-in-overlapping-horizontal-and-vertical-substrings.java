class Solution {
    public int countCells(String s) {
        int n = s.length();
        boolean[] horizontal = new boolean[n];
        boolean[] vertical = new boolean[n];

        // Check for horizontal substrings
        for (int i = 0; i < n; ) {
            if (s.charAt(i) == '-') {
                int start = i;
                while (i < n && s.charAt(i) == '-') {
                    i++;
                }
                if (i - start >= 2) {
                    for (int j = start; j < i; j++) {
                        horizontal[j] = true;
                    }
                }
            } else {
                i++;
            }
        }

        // Check for vertical substrings
        for (int i = 0; i < n; ) {
            if (s.charAt(i) == '|') {
                int start = i;
                while (i < n && s.charAt(i) == '|') {
                    i++;
                }
                if (i - start >= 2) {
                    for (int j = start; j < i; j++) {
                        vertical[j] = true;
                    }
                }
            } else {
                i++;
            }
        }

        // Count overlapping cells
        int count = 0;
        for (int i = 0; i < n; i++) {
            if (horizontal[i] && vertical[i]) {
                count++;
            }
        }

        return count;
    }
}
class Solution {
    public int strongPasswordChecker(String password) {
        int n = password.length();
        int missing = 0;
        if (!password.matches(".*[a-z].*")) missing++;
        if (!password.matches(".*[A-Z].*")) missing++;
        if (!password.matches(".*\\d.*")) missing++;

        int changes = 0;
        if (n < 6) {
            changes = Math.max(missing, 6 - n);
        } else if (n > 20) {
            changes = n - 20;
            int[] counts = new int[3];
            for (int i = 0; i < n;) {
                int j = i;
                while (j < n && password.charAt(i) == password.charAt(j)) j++;
                int len = j - i;
                if (len >= 3) {
                    counts[len % 3]++;
                }
                i = j;
            }

            for (int i = 0; i < 3; i++) {
                while (changes > 0 && counts[i] > 0) {
                    changes--;
                    counts[i]--;
                }
            }

            changes = (n - 20) + Math.max(missing, 0);
        } else {
            int i = 0;
            while (i < n) {
                int j = i;
                while (j < n && password.charAt(i) == password.charAt(j)) j++;
                int len = j - i;
                if (len >= 3) {
                    changes += len / 3;
                }
                i = j;
            }
            changes = Math.max(missing, changes);
        }

        return changes;
    }
}
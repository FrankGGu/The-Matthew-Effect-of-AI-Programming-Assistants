class Solution {
    public int minimumChanges(String s) {
        int n = s.length();
        int changes = 0;

        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '0') {
                if (i > 0 && s.charAt(i - 1) == '0') {
                    changes++;
                    i++;
                }
            } else {
                if (i > 0 && s.charAt(i - 1) == '1') {
                    changes++;
                    i++;
                }
            }
        }

        return changes;
    }
}
class Solution {
    public String smallestNumber(String pattern) {
        int n = pattern.length();
        int[] result = new int[n + 1];
        boolean[] used = new boolean[n + 2];

        for (int i = 0; i < n; i++) {
            if (pattern.charAt(i) == 'I') {
                result[i] = getNext(used);
            } else {
                int j = i;
                while (j >= 0 && (j == n || pattern.charAt(j) == 'D')) {
                    j--;
                }
                for (int k = j + 1; k <= i; k++) {
                    result[k] = getNext(used);
                }
                i = j;
            }
        }

        result[n] = getNext(used);

        StringBuilder sb = new StringBuilder();
        for (int num : result) {
            sb.append(num);
        }

        return sb.toString();
    }

    private int getNext(boolean[] used) {
        for (int i = 1; i < used.length; i++) {
            if (!used[i]) {
                used[i] = true;
                return i;
            }
        }
        return -1;
    }
}
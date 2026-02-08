class Solution {
    public List<Integer> beautifulIndices(String s, String a, String b, int k) {
        List<Integer> aIndices = findPatternIndices(s, a);
        List<Integer> bIndices = findPatternIndices(s, b);
        List<Integer> result = new ArrayList<>();

        if (aIndices.isEmpty() || bIndices.isEmpty()) {
            return result;
        }

        int i = 0, j = 0;
        while (i < aIndices.size() && j < bIndices.size()) {
            int aPos = aIndices.get(i);
            int bPos = bIndices.get(j);
            if (Math.abs(aPos - bPos) <= k) {
                result.add(aPos);
                i++;
            } else if (aPos < bPos) {
                i++;
            } else {
                j++;
            }
        }

        return result;
    }

    private List<Integer> findPatternIndices(String s, String pattern) {
        List<Integer> indices = new ArrayList<>();
        if (pattern.isEmpty()) {
            return indices;
        }
        int[] lps = computeLPS(pattern);
        int i = 0, j = 0;
        while (i < s.length()) {
            if (s.charAt(i) == pattern.charAt(j)) {
                i++;
                j++;
                if (j == pattern.length()) {
                    indices.add(i - j);
                    j = lps[j - 1];
                }
            } else {
                if (j != 0) {
                    j = lps[j - 1];
                } else {
                    i++;
                }
            }
        }
        return indices;
    }

    private int[] computeLPS(String pattern) {
        int[] lps = new int[pattern.length()];
        int len = 0;
        int i = 1;
        while (i < pattern.length()) {
            if (pattern.charAt(i) == pattern.charAt(len)) {
                len++;
                lps[i] = len;
                i++;
            } else {
                if (len != 0) {
                    len = lps[len - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }
        return lps;
    }
}
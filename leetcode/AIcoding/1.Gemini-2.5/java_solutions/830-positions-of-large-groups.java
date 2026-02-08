class Solution {
    public List<List<Integer>> largeGroupPositions(String s) {
        List<List<Integer>> result = new ArrayList<>();
        if (s == null || s.length() < 3) {
            return result;
        }

        int n = s.length();
        int i = 0;
        while (i < n) {
            int j = i;
            while (j < n && s.charAt(j) == s.charAt(i)) {
                j++;
            }
            // Group found from i to j-1
            if (j - i >= 3) {
                result.add(Arrays.asList(i, j - 1));
            }
            i = j; // Move to the start of the next potential group
        }

        return result;
    }
}
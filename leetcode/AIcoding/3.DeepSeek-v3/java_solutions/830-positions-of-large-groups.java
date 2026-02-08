class Solution {
    public List<List<Integer>> largeGroupPositions(String s) {
        List<List<Integer>> result = new ArrayList<>();
        int start = 0;
        for (int end = 0; end < s.length(); end++) {
            if (end == s.length() - 1 || s.charAt(end) != s.charAt(end + 1)) {
                if (end - start + 1 >= 3) {
                    result.add(Arrays.asList(start, end));
                }
                start = end + 1;
            }
        }
        return result;
    }
}
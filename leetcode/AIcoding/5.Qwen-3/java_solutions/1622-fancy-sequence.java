public class Solution {
    public List<Integer> countOfPeaks(String s) {
        List<Integer> result = new ArrayList<>();
        int n = s.length();
        for (int i = 1; i < n - 1; i++) {
            if (s.charAt(i) > s.charAt(i - 1) && s.charAt(i) > s.charAt(i + 1)) {
                result.add(1);
            } else if (s.charAt(i) < s.charAt(i - 1) && s.charAt(i) < s.charAt(i + 1)) {
                result.add(1);
            } else {
                result.add(0);
            }
        }
        return result;
    }
}
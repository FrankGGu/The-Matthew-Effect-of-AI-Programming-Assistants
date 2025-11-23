class Solution {
    public int maxNumOfSubstrings(String s) {
        int n = s.length();
        int[] left = new int[26], right = new int[26];
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            right[c - 'a'] = i;
        }
        for (int i = n - 1; i >= 0; i--) {
            char c = s.charAt(i);
            if (left[c - 'a'] == 0) {
                left[c - 'a'] = i + 1;
            }
        }
        List<int[]> intervals = new ArrayList<>();
        for (int i = 0; i < 26; i++) {
            if (left[i] > 0) {
                int start = left[i] - 1;
                int end = right[i];
                for (int j = start; j <= end; j++) {
                    if (left[s.charAt(j) - 'a'] > start) {
                        end = Math.max(end, right[s.charAt(j) - 'a']);
                    }
                }
                intervals.add(new int[]{start, end});
            }
        }
        intervals.sort((a, b) -> a[1] - b[1]);
        int count = 0, lastEnd = -1;
        for (int[] interval : intervals) {
            if (interval[0] > lastEnd) {
                count++;
                lastEnd = interval[1];
            }
        }
        return count;
    }
}
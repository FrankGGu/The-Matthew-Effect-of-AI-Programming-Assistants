class Solution {
    public List<Integer> mostVisited(int n, int[] rounds) {
        int[] count = new int[n + 1];
        int start = rounds[0];
        for (int i = 1; i < rounds.length; i++) {
            int end = rounds[i];
            while (start != end) {
                count[start]++;
                start++;
                if (start > n) {
                    start = 1;
                }
            }
            count[start]++;
            start = end == n ? 1 : end + 1;
        }
        int max = 0;
        List<Integer> result = new ArrayList<>();
        for (int i = 1; i <= n; i++) {
            if (count[i] > max) {
                max = count[i];
                result.clear();
                result.add(i);
            } else if (count[i] == max) {
                result.add(i);
            }
        }
        return result;
    }
}
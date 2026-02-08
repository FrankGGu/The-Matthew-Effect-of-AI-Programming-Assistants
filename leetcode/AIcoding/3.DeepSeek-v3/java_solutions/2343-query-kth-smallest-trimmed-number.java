class Solution {
    public int[] smallestTrimmedNumbers(String[] nums, int[][] queries) {
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int k = queries[i][0];
            int trim = queries[i][1];
            PriorityQueue<Pair<String, Integer>> pq = new PriorityQueue<>(
                (a, b) -> a.getKey().equals(b.getKey()) ? 
                b.getValue() - a.getValue() : b.getKey().compareTo(a.getKey())
            );
            for (int j = 0; j < nums.length; j++) {
                String trimmed = nums[j].substring(nums[j].length() - trim);
                pq.offer(new Pair<>(trimmed, j));
                if (pq.size() > k) {
                    pq.poll();
                }
            }
            result[i] = pq.poll().getValue();
        }
        return result;
    }
}
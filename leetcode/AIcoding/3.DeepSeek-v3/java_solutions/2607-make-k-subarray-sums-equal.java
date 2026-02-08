class Solution {
    public long makeSubKSumEqual(int[] arr, int k) {
        int n = arr.length;
        boolean[] visited = new boolean[n];
        long res = 0;
        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                List<Integer> group = new ArrayList<>();
                int j = i;
                while (!visited[j]) {
                    visited[j] = true;
                    group.add(arr[j]);
                    j = (j + k) % n;
                }
                Collections.sort(group);
                int median = group.get(group.size() / 2);
                for (int num : group) {
                    res += Math.abs(num - median);
                }
            }
        }
        return res;
    }
}
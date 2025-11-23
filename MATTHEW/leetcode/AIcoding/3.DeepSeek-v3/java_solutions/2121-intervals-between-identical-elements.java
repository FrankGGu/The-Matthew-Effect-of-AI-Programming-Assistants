class Solution {
    public long[] getDistances(int[] arr) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        for (int i = 0; i < arr.length; i++) {
            map.computeIfAbsent(arr[i], k -> new ArrayList<>()).add(i);
        }
        long[] res = new long[arr.length];
        for (List<Integer> list : map.values()) {
            int n = list.size();
            long[] prefix = new long[n];
            prefix[0] = list.get(0);
            for (int i = 1; i < n; i++) {
                prefix[i] = prefix[i - 1] + list.get(i);
            }
            for (int i = 0; i < n; i++) {
                long leftSum = (long) list.get(i) * i - (i > 0 ? prefix[i - 1] : 0);
                long rightSum = (prefix[n - 1] - prefix[i]) - (long) list.get(i) * (n - 1 - i);
                res[list.get(i)] = leftSum + rightSum;
            }
        }
        return res;
    }
}
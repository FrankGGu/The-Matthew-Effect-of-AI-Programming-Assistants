class Solution {
    public int[] closestEqual(int[] arr, int[][] queries) {
        int n = arr.length;
        int[] result = new int[queries.length];
        Map<Integer, List<Integer>> valueIndicesMap = new HashMap<>();

        for (int i = 0; i < n; i++) {
            valueIndicesMap.computeIfAbsent(arr[i], k -> new ArrayList<>()).add(i);
        }

        for (int i = 0; i < queries.length; i++) {
            int idx = queries[i][0];
            int target = arr[idx];
            int closestIndex = -1;
            int minDistance = Integer.MAX_VALUE;

            if (valueIndicesMap.containsKey(target)) {
                for (int index : valueIndicesMap.get(target)) {
                    if (index != idx) {
                        int distance = Math.abs(index - idx);
                        if (distance < minDistance) {
                            minDistance = distance;
                            closestIndex = index;
                        }
                    }
                }
            }
            result[i] = closestIndex;
        }

        return result;
    }
}
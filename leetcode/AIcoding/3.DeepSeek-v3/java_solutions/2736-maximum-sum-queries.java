import java.util.*;

class Solution {
    public int[] maximumSumQueries(int[] nums1, int[] nums2, int[][] queries) {
        int n = nums1.length;
        int q = queries.length;
        int[] ans = new int[q];
        List<int[]> list = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            list.add(new int[]{nums1[i], nums2[i]});
        }
        Collections.sort(list, (a, b) -> b[0] - a[0]);
        Integer[] idx = new Integer[q];
        for (int i = 0; i < q; i++) idx[i] = i;
        Arrays.sort(idx, (a, b) -> queries[b][0] - queries[a][0]);
        TreeMap<Integer, Integer> map = new TreeMap<>();
        int j = 0;
        for (int i : idx) {
            int x = queries[i][0], y = queries[i][1];
            while (j < n && list.get(j)[0] >= x) {
                int num1 = list.get(j)[0], num2 = list.get(j)[1];
                int sum = num1 + num2;
                Integer key = map.floorKey(num2);
                if (key == null || map.get(key) < sum) {
                    map.put(num2, sum);
                    while (true) {
                        Integer higher = map.higherKey(num2);
                        if (higher == null || map.get(higher) > sum) break;
                        map.remove(higher);
                    }
                }
                j++;
            }
            Integer resKey = map.ceilingKey(y);
            ans[i] = resKey == null ? -1 : map.get(resKey);
        }
        return ans;
    }
}
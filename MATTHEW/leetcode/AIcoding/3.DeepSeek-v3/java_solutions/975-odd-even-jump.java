import java.util.TreeMap;

class Solution {
    public int oddEvenJumps(int[] arr) {
        int n = arr.length;
        if (n == 0) return 0;
        boolean[] odd = new boolean[n];
        boolean[] even = new boolean[n];
        odd[n - 1] = even[n - 1] = true;
        TreeMap<Integer, Integer> map = new TreeMap<>();
        map.put(arr[n - 1], n - 1);
        int res = 1;

        for (int i = n - 2; i >= 0; i--) {
            Integer higher = map.ceilingKey(arr[i]);
            Integer lower = map.floorKey(arr[i]);

            if (higher != null) {
                odd[i] = even[map.get(higher)];
            }
            if (lower != null) {
                even[i] = odd[map.get(lower)];
            }

            if (odd[i]) {
                res++;
            }

            map.put(arr[i], i);
        }

        return res;
    }
}
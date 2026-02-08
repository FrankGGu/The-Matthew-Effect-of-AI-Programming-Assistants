class Solution {
    public int minOperations(int[] target, int[] arr) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < target.length; i++) {
            map.put(target[i], i);
        }

        List<Integer> list = new ArrayList<>();
        for (int num : arr) {
            if (map.containsKey(num)) {
                list.add(map.get(num));
            }
        }

        int[] tails = new int[list.size()];
        int size = 0;
        for (int x : list) {
            int i = 0, j = size;
            while (i != j) {
                int m = (i + j) / 2;
                if (tails[m] < x) {
                    i = m + 1;
                } else {
                    j = m;
                }
            }
            tails[i] = x;
            if (i == size) {
                size++;
            }
        }

        return target.length - size;
    }
}
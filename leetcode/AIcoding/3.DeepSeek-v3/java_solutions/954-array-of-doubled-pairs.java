class Solution {
    public boolean canReorderDoubled(int[] arr) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : arr) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        Integer[] sortedArr = new Integer[arr.length];
        for (int i = 0; i < arr.length; i++) {
            sortedArr[i] = arr[i];
        }
        Arrays.sort(sortedArr, (a, b) -> Math.abs(a) - Math.abs(b));

        for (int num : sortedArr) {
            if (count.get(num) == 0) {
                continue;
            }
            if (count.getOrDefault(2 * num, 0) <= 0) {
                return false;
            }
            count.put(num, count.get(num) - 1);
            count.put(2 * num, count.get(2 * num) - 1);
        }

        return true;
    }
}
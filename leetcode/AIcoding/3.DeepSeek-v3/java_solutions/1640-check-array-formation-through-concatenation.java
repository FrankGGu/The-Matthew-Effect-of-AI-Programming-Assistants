class Solution {
    public boolean canFormArray(int[] arr, int[][] pieces) {
        Map<Integer, int[]> map = new HashMap<>();
        for (int[] piece : pieces) {
            map.put(piece[0], piece);
        }

        int index = 0;
        while (index < arr.length) {
            if (!map.containsKey(arr[index])) {
                return false;
            }
            int[] piece = map.get(arr[index]);
            for (int num : piece) {
                if (num != arr[index]) {
                    return false;
                }
                index++;
            }
        }
        return true;
    }
}
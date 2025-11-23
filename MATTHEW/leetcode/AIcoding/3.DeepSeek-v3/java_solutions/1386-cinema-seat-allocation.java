class Solution {
    public int maxNumberOfFamilies(int n, int[][] reservedSeats) {
        Map<Integer, Set<Integer>> map = new HashMap<>();
        for (int[] seat : reservedSeats) {
            int row = seat[0];
            int col = seat[1];
            map.putIfAbsent(row, new HashSet<>());
            map.get(row).add(col);
        }

        int res = 2 * (n - map.size());

        for (Set<Integer> set : map.values()) {
            boolean left = true;
            boolean right = true;
            boolean middle = true;

            for (int col : set) {
                if (col >= 2 && col <= 5) {
                    left = false;
                }
                if (col >= 4 && col <= 7) {
                    middle = false;
                }
                if (col >= 6 && col <= 9) {
                    right = false;
                }
            }

            if (left && right) {
                res += 2;
            } else if (left || right || middle) {
                res += 1;
            }
        }

        return res;
    }
}
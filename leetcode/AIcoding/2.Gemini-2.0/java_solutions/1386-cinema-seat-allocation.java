class Solution {
    public int maxNumberOfFamilies(int n, int[][] reservedSeats) {
        Map<Integer, Set<Integer>> reserved = new HashMap<>();
        for (int[] seat : reservedSeats) {
            int row = seat[0];
            int col = seat[1];
            reserved.computeIfAbsent(row, k -> new HashSet<>()).add(col);
        }

        int count = 2 * n;
        for (Map.Entry<Integer, Set<Integer>> entry : reserved.entrySet()) {
            int row = entry.getKey();
            Set<Integer> seats = entry.getValue();
            boolean left = false, middle = false, right = false;

            if (seats.contains(2) || seats.contains(3) || seats.contains(4) || seats.contains(5)) {
                left = true;
            }
            if (seats.contains(4) || seats.contains(5) || seats.contains(6) || seats.contains(7)) {
                middle = true;
            }
            if (seats.contains(6) || seats.contains(7) || seats.contains(8) || seats.contains(9)) {
                right = true;
            }

            if (left && middle && right) {
                count -= 2;
            } else if (left || middle || right) {
                count--;
            }
        }

        return count;
    }
}
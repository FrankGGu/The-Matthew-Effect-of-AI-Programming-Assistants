class Solution {
    public int[] separateSquares(int[] nums) {
        List<Integer> squares = new ArrayList<>();
        List<Integer> nonSquares = new ArrayList<>();

        for (int num : nums) {
            if (isPerfectSquare(num)) {
                squares.add(num);
            } else {
                nonSquares.add(num);
            }
        }

        int[] result = new int[nums.length];
        int index = 0;
        for (int square : squares) {
            result[index++] = square;
        }
        for (int nonSquare : nonSquares) {
            result[index++] = nonSquare;
        }

        return result;
    }

    private boolean isPerfectSquare(int num) {
        if (num < 0) {
            return false;
        }
        int sqrt = (int) Math.sqrt(num);
        return sqrt * sqrt == num;
    }
}
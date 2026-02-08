class Solution {
    public int[] maxPoints(int numArrows, int[] aliceArrows) {
        int n = aliceArrows.length;
        int[] result = new int[n];
        int maxPoints = 0;

        for (int i = 0; i < (1 << n); i++) {
            int points = 0, arrowsUsed = 0;
            int[] arrows = new int[n];

            for (int j = 0; j < n; j++) {
                if ((i & (1 << j)) != 0) {
                    arrows[j] = aliceArrows[j] + 1;
                    arrowsUsed += arrows[j];
                    points += j;
                }
            }

            if (arrowsUsed <= numArrows) {
                if (points > maxPoints) {
                    maxPoints = points;
                    result = arrows;
                }
            }
        }

        int remainingArrows = numArrows - Arrays.stream(result).sum();
        for (int j = 0; j < n; j++) {
            if (result[j] > 0) {
                remainingArrows += result[j] - 1;
                result[j] = result[j] - 1;
            }
        }

        if (remainingArrows > 0) {
            result[0] += remainingArrows;
        }

        return result;
    }
}
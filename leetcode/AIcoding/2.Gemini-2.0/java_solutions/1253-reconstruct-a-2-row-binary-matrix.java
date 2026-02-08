class Solution {
    public List<List<Integer>> reconstructMatrix(int upper, int lower, int[] colsum) {
        int n = colsum.length;
        int sum = 0;
        int two = 0;
        for (int i = 0; i < n; i++) {
            sum += colsum[i];
            if (colsum[i] == 2) {
                two++;
            }
        }

        if (sum != upper + lower || two > upper || two > lower) {
            return new ArrayList<>();
        }

        List<List<Integer>> result = new ArrayList<>();
        List<Integer> row1 = new ArrayList<>();
        List<Integer> row2 = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            if (colsum[i] == 2) {
                row1.add(1);
                row2.add(1);
                upper--;
                lower--;
            } else if (colsum[i] == 1) {
                if (upper > lower) {
                    row1.add(1);
                    row2.add(0);
                    upper--;
                } else {
                    row1.add(0);
                    row2.add(1);
                    lower--;
                }
            } else {
                row1.add(0);
                row2.add(0);
            }
        }

        if (upper != 0 || lower != 0) {
            return new ArrayList<>();
        }

        result.add(row1);
        result.add(row2);

        return result;
    }
}
class Solution {
    public List<List<Integer>> reconstructMatrix(int upper, int lower, int[] colsum) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> upperRow = new ArrayList<>();
        List<Integer> lowerRow = new ArrayList<>();

        for (int sum : colsum) {
            if (sum == 2) {
                upperRow.add(1);
                lowerRow.add(1);
                upper--;
                lower--;
            } else if (sum == 0) {
                upperRow.add(0);
                lowerRow.add(0);
            } else {
                if (upper >= lower) {
                    upperRow.add(1);
                    lowerRow.add(0);
                    upper--;
                } else {
                    upperRow.add(0);
                    lowerRow.add(1);
                    lower--;
                }
            }
        }

        if (upper != 0 || lower != 0) {
            return new ArrayList<>();
        }

        result.add(upperRow);
        result.add(lowerRow);
        return result;
    }
}
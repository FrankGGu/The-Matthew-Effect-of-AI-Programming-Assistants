class Solution {
    public List<String> cellsInRange(String s) {
        List<String> result = new ArrayList<>();
        char startCol = s.charAt(0);
        char startRow = s.charAt(1);
        char endCol = s.charAt(3);
        char endRow = s.charAt(4);

        for (char col = startCol; col <= endCol; col++) {
            for (char row = startRow; row <= endRow; row++) {
                result.add(String.valueOf(col) + String.valueOf(row));
            }
        }

        return result;
    }
}
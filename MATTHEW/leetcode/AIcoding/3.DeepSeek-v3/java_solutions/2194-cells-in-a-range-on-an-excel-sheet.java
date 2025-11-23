class Solution {
    public List<String> cellsInRange(String s) {
        List<String> result = new ArrayList<>();
        char startCol = s.charAt(0);
        char endCol = s.charAt(3);
        int startRow = s.charAt(1) - '0';
        int endRow = s.charAt(4) - '0';

        for (char c = startCol; c <= endCol; c++) {
            for (int r = startRow; r <= endRow; r++) {
                result.add("" + c + r);
            }
        }

        return result;
    }
}
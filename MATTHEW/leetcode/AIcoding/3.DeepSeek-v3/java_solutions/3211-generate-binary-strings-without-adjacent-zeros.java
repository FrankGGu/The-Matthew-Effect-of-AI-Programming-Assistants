class Solution {
    public List<String> generateBinaryStrings(int n) {
        List<String> result = new ArrayList<>();
        backtrack(result, "", n);
        return result;
    }

    private void backtrack(List<String> result, String current, int n) {
        if (current.length() == n) {
            result.add(current);
            return;
        }

        backtrack(result, current + "1", n);

        if (current.isEmpty() || current.charAt(current.length() - 1) != '0') {
            backtrack(result, current + "0", n);
        }
    }
}
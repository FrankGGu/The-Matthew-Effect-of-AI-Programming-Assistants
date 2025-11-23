class Solution {
    public String getHappyString(int n, int k) {
        List<String> happyStrings = new ArrayList<>();
        generateHappyStrings(n, new StringBuilder(), happyStrings);
        if (happyStrings.size() < k) {
            return "";
        }
        return happyStrings.get(k - 1);
    }

    private void generateHappyStrings(int n, StringBuilder current, List<String> happyStrings) {
        if (current.length() == n) {
            happyStrings.add(current.toString());
            return;
        }
        for (char c = 'a'; c <= 'c'; c++) {
            if (current.length() == 0 || current.charAt(current.length() - 1) != c) {
                current.append(c);
                generateHappyStrings(n, current, happyStrings);
                current.deleteCharAt(current.length() - 1);
            }
        }
    }
}
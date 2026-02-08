class Solution {
    public String makeLargestSpecial(String S) {
        List<String> substrings = new ArrayList<>();
        int count = 0, last = 0;

        for (int i = 0; i < S.length(); i++) {
            count += S.charAt(i) == '1' ? 1 : -1;
            if (count == 0) {
                substrings.add("1" + makeLargestSpecial(S.substring(last + 1, i)) + "0");
                last = i + 1;
            }
        }

        Collections.sort(substrings, Collections.reverseOrder());
        return String.join("", substrings);
    }
}
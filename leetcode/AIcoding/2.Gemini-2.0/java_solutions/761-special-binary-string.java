class Solution {
    public String makeLargestSpecial(String s) {
        if (s == null || s.length() <= 2) {
            return s;
        }

        int count = 0;
        int start = 0;
        List<String> subStrings = new ArrayList<>();

        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '1') {
                count++;
            } else {
                count--;
            }

            if (count == 0) {
                subStrings.add("1" + makeLargestSpecial(s.substring(start + 1, i)) + "0");
                start = i + 1;
            }
        }

        Collections.sort(subStrings, Collections.reverseOrder());

        StringBuilder result = new StringBuilder();
        for (String subString : subStrings) {
            result.append(subString);
        }

        return result.toString();
    }
}
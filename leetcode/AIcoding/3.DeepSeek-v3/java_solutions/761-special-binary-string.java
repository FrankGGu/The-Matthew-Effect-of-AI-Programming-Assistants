class Solution {
    public String makeLargestSpecial(String s) {
        List<String> specials = new ArrayList<>();
        int count = 0;
        int start = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '1') {
                count++;
            } else {
                count--;
            }
            if (count == 0) {
                specials.add("1" + makeLargestSpecial(s.substring(start + 1, i)) + "0");
                start = i + 1;
            }
        }
        Collections.sort(specials, Collections.reverseOrder());
        return String.join("", specials);
    }
}
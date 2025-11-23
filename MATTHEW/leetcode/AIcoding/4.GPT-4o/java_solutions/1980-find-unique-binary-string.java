class Solution {
    public String findUniqueBinaryString(String[] nums) {
        Set<String> numSet = new HashSet<>(Arrays.asList(nums));
        StringBuilder unique = new StringBuilder();

        for (int i = 0; i < nums.length; i++) {
            unique.append('0');
        }

        while (numSet.contains(unique.toString())) {
            for (int i = unique.length() - 1; i >= 0; i--) {
                if (unique.charAt(i) == '0') {
                    unique.setCharAt(i, '1');
                    break;
                } else {
                    unique.setCharAt(i, '0');
                }
            }
        }

        return unique.toString();
    }
}
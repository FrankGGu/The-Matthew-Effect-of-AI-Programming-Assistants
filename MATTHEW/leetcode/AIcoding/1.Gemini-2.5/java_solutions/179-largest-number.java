import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public String largestNumber(int[] nums) {
        if (nums == null || nums.length == 0) {
            return "";
        }

        // Convert int array to String array
        String[] sNums = new String[nums.length];
        for (int i = 0; i < nums.length; i++) {
            sNums[i] = String.valueOf(nums[i]);
        }

        // Custom comparator to sort strings
        // For two strings s1 and s2, we compare s2+s1 and s1+s2.
        // If s2+s1 is lexicographically greater than s1+s2, then s2 should come before s1.
        // Example: s1="3", s2="30". s2+s1="303", s1+s2="330".
        // "303".compareTo("330") is negative, meaning "303" < "330".
        // So, s1 should come before s2 (for forming "330").
        // The comparator returns a negative value if s1 should come before s2.
        // So, if (s2+s1) is smaller than (s1+s2), it means s1 should come before s2,
        // and the comparator should return a negative value.
        // This is achieved by (s2 + s1).compareTo(s1 + s2).
        Arrays.sort(sNums, new Comparator<String>() {
            @Override
            public int compare(String s1, String s2) {
                String str1 = s1 + s2;
                String str2 = s2 + s1;
                return str2.compareTo(str1); // For descending order based on this custom logic
            }
        });

        // Handle edge case: if the largest number is "0", it means all numbers were 0
        // (e.g., [0,0,0] should return "0" not "000")
        if (sNums[0].equals("0")) {
            return "0";
        }

        // Concatenate the sorted strings
        StringBuilder sb = new StringBuilder();
        for (String s : sNums) {
            sb.append(s);
        }

        return sb.toString();
    }
}
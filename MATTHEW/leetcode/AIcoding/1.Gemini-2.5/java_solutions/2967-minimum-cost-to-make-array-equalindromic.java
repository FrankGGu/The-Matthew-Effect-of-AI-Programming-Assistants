import java.util.*;

class Solution {

    public long minimumCost(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        long median = nums[n / 2];

        TreeSet<Long> allPalindromes = new TreeSet<>();
        generatePalindromes(allPalindromes);

        Set<Long> candidatePalindromes = new HashSet<>();

        Long floorP = allPalindromes.floor(median);
        Long ceilP = allPalindromes.ceiling(median);

        if (floorP != null) {
            candidatePalindromes.add(floorP);
            Long current = floorP;
            for (int k = 0; k < 5 && current != null; k++) {
                current = allPalindromes.lower(current);
                if (current != null) {
                    candidatePalindromes.add(current);
                }
            }
        }
        if (ceilP != null) {
            candidatePalindromes.add(ceilP);
            Long current = ceilP;
            for (int k = 0; k < 5 && current != null; k++) {
                current = allPalindromes.higher(current);
                if (current != null) {
                    candidatePalindromes.add(current);
                }
            }
        }

        long minCost = Long.MAX_VALUE;

        for (long p : candidatePalindromes) {
            long currentCost = 0;
            for (int num : nums) {
                currentCost += Math.abs(num - p);
            }
            minCost = Math.min(minCost, currentCost);
        }

        return minCost;
    }

    private void generatePalindromes(TreeSet<Long> allPalindromes) {
        final long MAX_VALUE = 2_000_000_000L; 

        for (long i = 1; i <= 100000; i++) { 
            String s = String.valueOf(i);
            String rev_s = new StringBuilder(s).reverse().toString();

            // Odd length palindrome (e.g., 123 -> 12321)
            String p_odd_str = s + rev_s.substring(1);
            long p_odd = Long.parseLong(p_odd_str);
            if (p_odd <= MAX_VALUE) {
                allPalindromes.add(p_odd);
            }

            // Even length palindrome (e.g., 123 -> 123321)
            String p_even_str = s + rev_s;
            long p_even = Long.parseLong(p_even_str);
            if (p_even <= MAX_VALUE) {
                allPalindromes.add(p_even);
            }
        }
    }
}
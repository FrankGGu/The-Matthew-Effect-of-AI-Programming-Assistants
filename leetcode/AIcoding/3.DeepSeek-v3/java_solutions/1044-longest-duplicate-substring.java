class Solution {
    private long modulus = (long) Math.pow(2, 32);
    private int base = 26;

    public String longestDupSubstring(String S) {
        int n = S.length();
        int[] nums = new int[n];
        for (int i = 0; i < n; ++i) {
            nums[i] = (int) S.charAt(i) - (int) 'a';
        }
        int left = 1, right = n;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (search(mid, nums) != -1) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        int start = search(left - 1, nums);
        return start != -1 ? S.substring(start, start + left - 1) : "";
    }

    private int search(int len, int[] nums) {
        long hash = 0;
        for (int i = 0; i < len; i++) {
            hash = (hash * base + nums[i]) % modulus;
        }
        Set<Long> seen = new HashSet<>();
        seen.add(hash);
        long aL = 1;
        for (int i = 1; i <= len; i++) {
            aL = (aL * base) % modulus;
        }
        for (int start = 1; start < nums.length - len + 1; start++) {
            hash = (hash * base - nums[start - 1] * aL % modulus + modulus) % modulus;
            hash = (hash + nums[start + len - 1]) % modulus;
            if (seen.contains(hash)) {
                return start;
            }
            seen.add(hash);
        }
        return -1;
    }
}
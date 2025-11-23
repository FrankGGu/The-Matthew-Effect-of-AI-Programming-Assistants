class Solution {
    public int maximumSetSize(int[] nums1, int[] nums2) {
        Set<Integer> set1 = new HashSet<>();
        Set<Integer> set2 = new HashSet<>();
        Set<Integer> common = new HashSet<>();

        for (int num : nums1) {
            set1.add(num);
        }
        for (int num : nums2) {
            if (set1.contains(num)) {
                common.add(num);
            }
            set2.add(num);
        }

        int n = nums1.length;
        int maxUnique1 = Math.min(set1.size() - common.size(), n / 2);
        int maxUnique2 = Math.min(set2.size() - common.size(), n / 2);
        int remaining = Math.max(0, common.size() - (n - maxUnique1 - maxUnique2));

        return maxUnique1 + maxUnique2 + remaining;
    }
}
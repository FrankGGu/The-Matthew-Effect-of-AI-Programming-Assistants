class Solution {
    public int maxGroups(int[] counts) {
        Arrays.sort(counts);
        int groups = 0;
        int left = 0;
        int right = counts.length - 1;
        while (left <= right) {
            groups++;
            int sum = counts[right];
            right--;
            while (left <= right && sum <= counts[right]) {
                sum += counts[left];
                left++;
            }
        }
        return groups;
    }
}
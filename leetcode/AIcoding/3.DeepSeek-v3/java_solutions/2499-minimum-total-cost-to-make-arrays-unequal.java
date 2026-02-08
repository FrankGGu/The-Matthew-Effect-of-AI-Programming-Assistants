class Solution {
    public int minimumTotalCost(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int totalCost = 0;
        int[] freq = new int[n + 1];
        int maxFreq = 0;
        int maxNum = -1;
        int count = 0;

        for (int i = 0; i < n; i++) {
            if (nums1[i] == nums2[i]) {
                totalCost += i;
                freq[nums1[i]]++;
                if (freq[nums1[i]] > maxFreq) {
                    maxFreq = freq[nums1[i]];
                    maxNum = nums1[i];
                }
                count++;
            }
        }

        for (int i = 0; i < n; i++) {
            if (maxFreq > count / 2 && nums1[i] != nums2[i] && nums1[i] != maxNum && nums2[i] != maxNum) {
                totalCost += i;
                count++;
            }
        }

        if (maxFreq > count / 2) {
            return -1;
        } else {
            return totalCost;
        }
    }
}
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int maximumSetSize(int[] nums1, int[] nums2) {
        int n = nums1.length;
        Set<Integer> s1 = new HashSet<>();
        Set<Integer> s2 = new HashSet<>();
        Set<Integer> common = new HashSet<>();

        for (int num : nums1) {
            s1.add(num);
        }
        for (int num : nums2) {
            s2.add(num);
        }

        for (int num : nums1) {
            if (s2.contains(num)) {
                common.add(num);
            }
        }

        int unique1 = s1.size() - common.size();
        int unique2 = s2.size() - common.size();
        int commonSize = common.size();

        int result = 0;

        if (unique1 <= n / 2 && unique2 <= n / 2) {
            result = unique1 + unique2 + commonSize;
        } else if (unique1 > n / 2) {
            int takeFrom1 = Math.min(unique1 - n / 2, commonSize);
            result = n / 2 + unique2 + takeFrom1;
            result = Math.min(result, n);
        } else {
            int takeFrom2 = Math.min(unique2 - n / 2, commonSize);
            result = unique1 + n / 2 + takeFrom2;
            result = Math.min(result, n);
        }

        if (result > n) return n;

        return Math.min(result, n);
    }
}
class Solution {
    public long countInterestingSubarrays(int[] nums, int modulo, int k) {
        int n = nums.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 1; i <= n; i++) {
            prefixSum[i] = prefixSum[i - 1] + (nums[i - 1] % modulo == k ? 1 : 0);
        }

        long count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                long subarraySum = prefixSum[j + 1] - prefixSum[i];
                if (subarraySum % modulo == k) {
                    count++;
                }
            }
        }
        return count;
    }
}
```
```java
class Solution {
    public long countInterestingSubarrays(int[] nums, int modulo, int k) {
        int n = nums.length;
        long count = 0;
        int[] prefix = new int[n + 1];
        prefix[0] = 0;
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + (nums[i] % modulo == k ? 1 : 0);
        }

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                if ((prefix[j + 1] - prefix[i]) % modulo == k) {
                    count++;
                }
            }
        }

        return count;
    }
}
```
```java
class Solution {
    public long countInterestingSubarrays(int[] nums, int modulo, int k) {
        int n = nums.length;
        long count = 0;
        int[] prefix = new int[n + 1];
        prefix[0] = 0;
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + (nums[i] % modulo == k ? 1 : 0);
        }

        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i <= n; i++) {
            int remainder = (prefix[i] % modulo + modulo) % modulo;
            int target = (remainder - k + modulo) % modulo;
            count += map.getOrDefault(target, 0);
            map.put(remainder, map.getOrDefault(remainder, 0) + 1);
        }

        return count;
    }
}
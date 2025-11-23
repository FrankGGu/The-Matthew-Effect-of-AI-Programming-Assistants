class Solution {
    public int minimumDifference(int[] nums) {
        int n = nums.length / 2;
        int total = 0;
        for (int num : nums) total += num;

        List<List<Integer>> left = new ArrayList<>();
        List<List<Integer>> right = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            left.add(new ArrayList<>());
            right.add(new ArrayList<>());
        }

        for (int mask = 0; mask < (1 << n); mask++) {
            int sum = 0;
            int bits = 0;
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) != 0) {
                    sum += nums[i];
                    bits++;
                }
            }
            left.get(bits).add(sum);
        }

        for (int mask = 0; mask < (1 << n); mask++) {
            int sum = 0;
            int bits = 0;
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) != 0) {
                    sum += nums[n + i];
                    bits++;
                }
            }
            right.get(bits).add(sum);
        }

        for (int i = 0; i <= n; i++) {
            Collections.sort(right.get(i));
        }

        int minDiff = Integer.MAX_VALUE;
        for (int k = 0; k <= n; k++) {
            List<Integer> leftList = left.get(k);
            List<Integer> rightList = right.get(n - k);
            for (int sumLeft : leftList) {
                int target = (total - 2 * sumLeft) / 2;
                int idx = Collections.binarySearch(rightList, target);
                if (idx >= 0) {
                    minDiff = Math.min(minDiff, Math.abs(total - 2 * (sumLeft + rightList.get(idx))));
                } else {
                    idx = -idx - 1;
                    if (idx < rightList.size()) {
                        minDiff = Math.min(minDiff, Math.abs(total - 2 * (sumLeft + rightList.get(idx))));
                    }
                    if (idx > 0) {
                        minDiff = Math.min(minDiff, Math.abs(total - 2 * (sumLeft + rightList.get(idx - 1))));
                    }
                }
            }
        }
        return minDiff;
    }
}
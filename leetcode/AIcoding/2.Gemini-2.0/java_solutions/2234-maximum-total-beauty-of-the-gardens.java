class Solution {
    public long maximumBeauty(int[] flowers, long newFlowers, int target, int full, int partial) {
        int n = flowers.length;
        long ans = 0;
        Arrays.sort(flowers);
        long sum = 0;
        for (int flower : flowers) {
            sum += flower;
        }
        int cnt = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (flowers[i] >= target) {
                cnt++;
                sum -= flowers[i];
            } else {
                break;
            }
        }
        ans = (long) cnt * full;
        newFlowers -= (long) cnt * target - sum;

        if (newFlowers < 0) {
            return ans;
        }

        long maxPartial = 0;
        int left = 0;
        long currentSum = 0;
        for (int i = n - 1 - cnt; i >= 0; i--) {
            long numFull = (long) (n - 1 - cnt - i) * full;
            long need = Math.max(0, (long) target * (n - 1 - cnt - i) - (sum - (long) cnt * target - currentSum));
            long remain = newFlowers - need;
            if (remain < 0) {
                continue;
            }
            long low = flowers[0];
            long high = target - 1;
            long best = 0;
            while (low <= high) {
                long mid = low + (high - low) / 2;
                long need2 = 0;
                for (int j = 0; j <= i; j++) {
                    need2 += Math.max(0, mid - flowers[j]);
                }
                if (need2 <= remain) {
                    best = mid;
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
            maxPartial = Math.max(maxPartial, best);
            currentSum += flowers[i];

        }
        if (n - cnt > 0) {
                long low = flowers[0];
                long high = target - 1;
                long best = 0;
                while (low <= high) {
                    long mid = low + (high - low) / 2;
                    long need2 = 0;
                    for (int j = 0; j < n - cnt; j++) {
                        need2 += Math.max(0, mid - flowers[j]);
                    }
                    if (need2 <= newFlowers) {
                        best = mid;
                        low = mid + 1;
                    } else {
                        high = mid - 1;
                    }
                }
               maxPartial = Math.max(maxPartial, best);
        }

        ans = 0;
        for (int i = 0; i < n; i++) {
            if (flowers[i] + newFlowers / n >= target) {
                long numFull = Math.min(n, (newFlowers + sum) / target);
                long numPartial = 0;
                if (numFull < n) {
                    long remain = newFlowers + sum - numFull * target;
                    long low = flowers[0];
                    long high = target - 1;
                    long best = 0;
                    while (low <= high) {
                        long mid = low + (high - low) / 2;
                        long need2 = 0;
                        for (int j = 0; j < n - numFull; j++) {
                            need2 += Math.max(0, mid - flowers[j]);
                        }
                        if (need2 <= remain) {
                            best = mid;
                            low = mid + 1;
                        } else {
                            high = mid - 1;
                        }
                    numPartial = best;
                    }
                }
                ans = Math.max(ans, (long) numFull * full + numPartial * partial);
                break;

            }

        }

         for (int i = 0; i <= n; i++) {
            long need = (long) i * target;
            if (need <= newFlowers + sum) {
                long remain = newFlowers + sum - need;
                int remainingFlowers = n - i;

                if (remainingFlowers > 0) {
                    long low = 0;
                    long high = target - 1;
                    long bestPartial = 0;

                    while (low <= high) {
                        long mid = low + (high - low) / 2;
                        long needPartial = 0;
                        for (int j = 0; j < remainingFlowers; j++) {
                            needPartial += Math.max(0, mid - flowers[j]);
                        }

                        if (needPartial <= remain) {
                            bestPartial = mid;
                            low = mid + 1;
                        } else {
                            high = mid - 1;
                        }
                    }
                    ans = Math.max(ans, (long) i * full + bestPartial * partial);
                } else {
                    ans = Math.max(ans, (long) i * full);
                }
            }
        }

        return ans;
    }
}
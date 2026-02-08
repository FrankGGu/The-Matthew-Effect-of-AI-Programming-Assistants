import java.util.Arrays;

class Solution {
    public int minWastedSpace(int[] packages, int[][] boxes) {
        Arrays.sort(packages);
        long minWaste = Long.MAX_VALUE;
        long totalPackages = 0;
        int mod = 1000000007;

        for (int p : packages) {
            totalPackages = (totalPackages + p) % mod;
        }

        for (int[] box : boxes) {
            Arrays.sort(box);
            if (box[box.length - 1] < packages[packages.length - 1]) {
                continue;
            }

            long waste = 0;
            int prev = 0;
            for (int b : box) {
                int left = prev;
                int right = packages.length - 1;
                int last = -1;

                while (left <= right) {
                    int mid = left + (right - left) / 2;
                    if (packages[mid] <= b) {
                        last = mid;
                        left = mid + 1;
                    } else {
                        right = mid - 1;
                    }
                }

                if (last != -1 && last >= prev) {
                    long count = last - prev + 1;
                    waste = (waste + (b * count) % mod) % mod;
                    prev = last + 1;
                }
            }

            if(prev == packages.length){
                minWaste = Math.min(minWaste, waste);
            }
        }

        if (minWaste == Long.MAX_VALUE) {
            return -1;
        } else {
            return (int) ((minWaste - totalPackages + mod) % mod);
        }
    }
}
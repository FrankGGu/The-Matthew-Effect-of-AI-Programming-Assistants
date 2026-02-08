class Solution {
    public int solve(int[] a) {
        int n = a.length;
        int ans = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                for (int k = j + 1; k < n; k++) {
                    int sum = 0;
                    int max1 = 0, max2 = 0, max3 = 0;

                    for(int l = 0; l < n; l++) {
                        if(l != i && l != j && l != k) {
                            sum += a[l];
                        }
                    }

                    max1 = a[i];
                    max2 = a[j];
                    max3 = a[k];

                    ans = Math.max(ans, sum + max1 + max2 + max3);
                }
            }
        }
        return ans;
    }

    public int solveOptimized(int[] a) {
        int n = a.length;
        if (n <= 3) {
            int sum = 0;
            for (int x : a) {
                sum += x;
            }
            return sum;
        }

        Arrays.sort(a);
        int sum = 0;
        for (int i = n - 1; i >= n - 3; i--) {
            sum += a[i];
        }
        return sum;
    }

    public int maximumValueSum(int[] nums) {
        return solveOptimized(nums);
    }
}
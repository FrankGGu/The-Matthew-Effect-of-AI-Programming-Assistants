class Solution {
    public int minIncrements(int n, int[] nums) {
        long count = 0;
        int[] factors = new int[n + 1];
        factors[1] = 0;
        for (int i = 2; i <= n; i++) {
            factors[i] = i;
        }

        for (int num : nums) {
            int target = num;
            while (factors[target] != target) {
                target = factors[target];
            }

            if (target != 1) {
                count += target - num;
                factors[target] = gcd(target, num);
                int root = factors[target];
                int temp = target;
                while (factors[temp] != root) {
                    int next = factors[temp];
                    factors[temp] = root;
                    temp = next;
                }
            }
        }

        return (int) count;
    }

    private int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
}
import java.util.*;

class Solution {
    public int maximumScore(List<Integer> nums, int k) {
        int n = nums.size();
        int[] left = new int[n];
        int[] right = new int[n];
        Arrays.fill(right, n);
        Deque<Integer> stack = new ArrayDeque<>();

        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && getScore(nums.get(stack.peek())) < getScore(nums.get(i))) {
                right[stack.pop()] = i;
            }
            left[i] = stack.isEmpty() ? -1 : stack.peek();
            stack.push(i);
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> b[0] - a[0]);
        for (int i = 0; i < n; i++) {
            int l = i - left[i] - 1;
            int r = right[i] - i - 1;
            int total = l + r + 1;
            pq.offer(new int[]{nums.get(i), total});
        }

        long res = 1;
        int mod = 1000000007;
        while (!pq.isEmpty() && k > 0) {
            int[] curr = pq.poll();
            int num = curr[0];
            int cnt = curr[1];
            int take = Math.min(cnt, k);
            res = (res * pow(num, take, mod)) % mod;
            k -= take;
        }
        return (int) res;
    }

    private int getScore(int num) {
        int score = 0;
        for (int i = 2; i * i <= num; i++) {
            while (num % i == 0) {
                score++;
                num /= i;
            }
        }
        if (num > 1) {
            score++;
        }
        return score;
    }

    private long pow(long x, int n, int mod) {
        long res = 1;
        while (n > 0) {
            if (n % 2 == 1) {
                res = (res * x) % mod;
            }
            x = (x * x) % mod;
            n /= 2;
        }
        return res;
    }
}
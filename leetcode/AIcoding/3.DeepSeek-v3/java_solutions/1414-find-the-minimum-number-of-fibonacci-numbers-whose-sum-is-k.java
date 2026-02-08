class Solution {
    public int findMinFibonacciNumbers(int k) {
        List<Integer> fibs = new ArrayList<>();
        fibs.add(1);
        fibs.add(1);
        while (true) {
            int next = fibs.get(fibs.size() - 1) + fibs.get(fibs.size() - 2);
            if (next > k) break;
            fibs.add(next);
        }
        int count = 0;
        int remaining = k;
        for (int i = fibs.size() - 1; i >= 0; i--) {
            if (fibs.get(i) <= remaining) {
                remaining -= fibs.get(i);
                count++;
                if (remaining == 0) break;
            }
        }
        return count;
    }
}
class Solution {
    public int findMinFibonacciNumbers(int k) {
        List<Integer> fib = new ArrayList<>();
        fib.add(1);
        fib.add(1);
        while (fib.get(fib.size() - 1) <= k) {
            fib.add(fib.get(fib.size() - 1) + fib.get(fib.size() - 2));
        }

        int count = 0;
        for (int i = fib.size() - 1; i >= 0; i--) {
            if (k >= fib.get(i)) {
                k -= fib.get(i);
                count++;
            }
        }
        return count;
    }
}
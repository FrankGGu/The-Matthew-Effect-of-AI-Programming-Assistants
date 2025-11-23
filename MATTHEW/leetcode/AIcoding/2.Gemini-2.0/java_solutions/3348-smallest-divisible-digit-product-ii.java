class Solution {
    public int smallestDivisibleDigitProduct(int n, int target) {
        if (target == 1) {
            if (n == 1) return 1;
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < n; i++) {
                sb.append(1);
            }
            return Integer.parseInt(sb.toString());
        }

        List<Integer> digits = new ArrayList<>();
        for (int i = 9; i >= 2; i--) {
            while (target % i == 0) {
                digits.add(i);
                target /= i;
            }
        }

        if (target != 1) {
            return -1;
        }

        if (digits.size() > n) {
            return -1;
        }

        while (digits.size() < n) {
            digits.add(1);
        }

        Collections.sort(digits);

        StringBuilder sb = new StringBuilder();
        for (int digit : digits) {
            sb.append(digit);
        }

        return Integer.parseInt(sb.toString());
    }
}
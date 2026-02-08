class Solution {
    public int findNumbers(int[] digits) {
        Set<Integer> uniqueDigits = new HashSet<>();
        for (int d : digits) {
            uniqueDigits.add(d);
        }
        int count = 0;
        for (int i = 100; i < 1000; i += 2) {
            int num = i;
            boolean valid = true;
            Set<Integer> usedDigits = new HashSet<>();
            while (num > 0) {
                int d = num % 10;
                if (!uniqueDigits.contains(d)) {
                    valid = false;
                    break;
                }
                if (usedDigits.contains(d)) {
                    valid = false;
                    break;
                }
                usedDigits.add(d);
                num /= 10;
            }
            if (valid) {
                count++;
            }
        }
        return count;
    }
}
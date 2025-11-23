class Solution {
    public int sumOfMaxPrimeSubstrings(String s) {
        int n = s.length();
        int sum = 0;

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                String sub = s.substring(i, j + 1);
                int num;
                try {
                    num = Integer.parseInt(sub);
                } catch (NumberFormatException e) {
                    continue;
                }

                if (num > 1 && isPrime(num)) {
                    sum = Math.max(sum, num);
                }
            }
        }

        int totalSum = 0;
        for (int i = 0; i < n; i++) {
            int maxPrime = 0;
            for (int j = i; j < n; j++) {
                String sub = s.substring(i, j + 1);
                int num;
                try {
                    num = Integer.parseInt(sub);
                } catch (NumberFormatException e) {
                    continue;
                }

                if (num > 1 && isPrime(num)) {
                    maxPrime = Math.max(maxPrime, num);
                }
            }
            totalSum += maxPrime;
        }

        totalSum = 0;
        int k = 0;
        while(k < n){
            int maxPrime = 0;
            for(int l = k; l < n; l++){
                String sub = s.substring(k, l+1);
                 int num;
                try {
                    num = Integer.parseInt(sub);
                } catch (NumberFormatException e) {
                    continue;
                }
                 if (num > 1 && isPrime(num)) {
                    maxPrime = Math.max(maxPrime, num);
                }
            }
            if(maxPrime > 0){
                totalSum += maxPrime;
                int numStrLen = String.valueOf(maxPrime).length();
                k += numStrLen;
            } else {
                k++;
            }

        }

        return totalSum;
    }

    private boolean isPrime(int n) {
        if (n <= 1) {
            return false;
        }
        for (int i = 2; i <= Math.sqrt(n); i++) {
            if (n % i == 0) {
                return false;
            }
        }
        return true;
    }
}
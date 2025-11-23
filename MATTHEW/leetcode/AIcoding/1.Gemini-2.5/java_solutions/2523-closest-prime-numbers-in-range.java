import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public List<Integer> closestPrimes(int left, int right) {
        boolean[] isPrime = new boolean[right + 1];
        Arrays.fill(isPrime, true);
        if (right >= 0) isPrime[0] = false;
        if (right >= 1) isPrime[1] = false;

        for (int p = 2; p * p <= right; p++) {
            if (isPrime[p]) {
                for (int i = p * p; i <= right; i += p)
                    isPrime[i] = false;
            }
        }

        List<Integer> primesInRange = new ArrayList<>();
        for (int i = left; i <= right; i++) {
            if (isPrime[i]) {
                primesInRange.add(i);
            }
        }

        if (primesInRange.size() < 2) {
            return Arrays.asList(-1, -1);
        }

        int minDiff = Integer.MAX_VALUE;
        int prime1 = -1;
        int prime2 = -1;

        for (int i = 1; i < primesInRange.size(); i++) {
            int currentPrime = primesInRange.get(i);
            int prevPrime = primesInRange.get(i - 1);
            int diff = currentPrime - prevPrime;

            if (diff < minDiff) {
                minDiff = diff;
                prime1 = prevPrime;
                prime2 = currentPrime;
            }
        }

        return Arrays.asList(prime1, prime2);
    }
}
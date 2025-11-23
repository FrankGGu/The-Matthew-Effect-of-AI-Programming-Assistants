#include <vector>
#include <cmath>
#include <numeric>
#include <algorithm> // For std::min

long long count_primes_up_to(long long n) {
    if (n < 2) return 0;
    if (n == 2) return 1;

    // Sieve primes up to sqrt(n)
    // The maximum value for sqrt(n) is sqrt(10^9) approx 31622.
    // This part is a standard Sieve of Eratosthenes.
    long long limit_sqrt_n = sqrt(n);
    std::vector<bool> is_prime_small(limit_sqrt_n + 1, true);
    std::vector<long long> primes; // Stores primes found up to limit_sqrt_n

    is_prime_small[0] = is_prime_small[1] = false;
    for (long long p = 2; p <= limit_sqrt_n; ++p) {
        if (is_prime_small[p]) {
            primes.push_back(p);
            for (long long i = p * p; i <= limit_sqrt_n; i += p)
                is_prime_small[i] = false;
        }
    }

    long long count = primes.size(); // Count of primes up to limit_sqrt_n

    // Segmented sieve for numbers greater than limit_sqrt_n
    // We process numbers in blocks (segments) to save memory.
    // The block size is chosen to be around sqrt(n) for optimal performance
    // in terms of the number of primes to iterate over in each segment.
    long long segment_size = limit_sqrt_n; 
    if (segment_size < 1000) segment_size = 1000; // Ensure a minimum reasonable block size

    // Iterate through segments starting from limit_sqrt_n + 1
    for (long long k = limit_sqrt_n + 1; k <= n; k += segment_size) {
        long long low = k;
        long long high = std::min(k + segment_size - 1, n);

        // is_prime_segment marks numbers in the current segment [low, high]
        // as prime (true) or composite (false).
        std::vector<bool> is_prime_segment(high - low + 1, true);

        // For each prime p found in the initial sieve (up to limit_sqrt_n),
        // mark its multiples as composite in the current segment.
        for (long long p : primes) {
            // Calculate the first multiple of p that is >= low.
            // (low + p - 1) / p * p ensures it's the smallest multiple of p >= low.
            long long start_val = (low + p - 1) / p * p;

            // Ensure we start marking from p*p if p*p is in the segment and p is in primes.
            // This optimization avoids marking p itself if p is in the current segment.
            if (start_val < p * p) { 
                start_val = p * p;
            }

            // Mark all multiples of p in the current segment as composite.
            for (long long j = start_val; j <= high; j += p) {
                is_prime_segment[j - low] = false;
            }
        }

        // Count primes in the current segment.
        for (long long i = 0; i < is_prime_segment.size(); ++i) {
            if (is_prime_segment[i]) {
                count++;
            }
        }
    }

    return count;
}

class Solution {
public:
    long long nonSpecialCount(long long l, long long r) {

        // Helper lambda to count "special" numbers up to a given N.
        // A number is special if it's a perfect square of a prime (p*p).
        // So, we need to count primes p such that p*p <= N, which means p <= sqrt(N).
        // This is equivalent to finding pi(floor(sqrt(N))).
        auto countSpecial = [&](long long N) {
            if (N < 4) return 0LL; // Smallest special number is 2*2=4
            long long limit_p = sqrt(N); // Max prime to consider
            return count_primes_up_to(limit_p);
        };

        // Total special numbers in [l, r] = (special numbers <= r) - (special numbers <= l-1)
        long long special_count_up_to_r = countSpecial(r);
        long long special_count_up_to_l_minus_1 = countSpecial(l - 1);

        long long total_special_in_range = special_count_up_to_r - special_count_up_to_l_minus_1;

        // The count of numbers which are NOT special in [l, r]
        // is (total numbers in range) - (total special numbers in range).
        return (r - l + 1) - total_special_in_range;
    }
};
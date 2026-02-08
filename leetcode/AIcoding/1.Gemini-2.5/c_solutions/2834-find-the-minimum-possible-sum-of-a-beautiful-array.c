long long minPossibleSum(int n, int target) {
    long long ans = 0;

    // Step 1: Pick numbers 1, 2, ..., k where k is the largest integer
    // such that i < target - i (i.e., i < target / 2).
    // These numbers are safe to pick because their "partners" (target - i)
    // are all greater than i, and thus have not been picked yet.
    // To minimize the sum, for any pair (i, target - i) that sums to target,
    // we should always pick the smaller number i.
    // The largest integer i satisfying i < target / 2 is (target - 1) / 2 using integer division.
    long long k_limit = (long long)(target - 1) / 2;

    // We can pick at most 'n' numbers in total. So, we pick min(n, k_limit) numbers from this range.
    long long count_from_small = (n < k_limit) ? n : k_limit;

    // Add the sum of these numbers (1 to count_from_small) to the total answer.
    // Sum of 1 to X is X * (X + 1) / 2.
    ans += count_from_small * (count_from_small + 1) / 2;

    // Update 'n' to reflect the remaining numbers that still need to be picked.
    n -= count_from_small;

    // Step 2: Pick the remaining 'n' numbers.
    // The numbers 1, ..., count_from_small have been picked.
    // Their partners (target - count_from_small), ..., (target - 1) are now forbidden.
    // All numbers between (count_from_small + 1) and (target - count_from_small - 1)
    // might also be part of forbidden pairs or other pairs.
    // The smallest positive integer that is guaranteed not to be picked and not forbidden
    // by any of the previous picks (1 to count_from_small) is 'target'.
    // Numbers greater than or equal to 'target' will have partners less than or equal to 0,
    // or partners that are already forbidden (if partner < target), or partners that are
    // also >= target, but since we pick in increasing order, the partner would be picked later.
    // Thus, we pick 'target', 'target + 1', 'target + 2', ... for the remaining 'n' elements.
    // This forms an arithmetic progression: target, target+1, ..., target+n-1.
    // The sum of an arithmetic progression is (number_of_terms / 2) * (first_term + last_term).
    // number_of_terms = n
    // first_term = target
    // last_term = target + n - 1

    // Ensure 'n' is cast to long long for multiplication to prevent overflow,
    // as 'target' can be up to 10^9 and 'n' up to 10^5,
    // leading to a sum that can exceed the maximum value of an int.
    ans += (long long)n * (2LL * target + n - 1) / 2;

    return ans;
}
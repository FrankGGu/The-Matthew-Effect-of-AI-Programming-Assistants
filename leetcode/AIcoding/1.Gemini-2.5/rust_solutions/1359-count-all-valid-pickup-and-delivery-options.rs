impl Solution {
    pub fn count_orders(n: i32) -> i32 {
        let n = n as i64;
        let modulo: i64 = 1_000_000_007;
        let mut ans: i64 = 1;

        // The number of valid sequences for n pairs can be derived using a recurrence relation.
        // Let f(n) be the number of valid sequences for n pairs.
        //
        // For n=1, we have P1, D1. Only 1 valid sequence: (P1, D1). So f(1) = 1.
        //
        // To find f(n) from f(n-1):
        // Consider the first (n-1) pairs, for which there are f(n-1) valid sequences.
        // Now we need to insert the n-th pair (Pn, Dn) into these sequences.
        // There are 2*(n-1) items already placed. These items create 2*(n-1) + 1 possible slots
        // where Pn and Dn can be inserted.
        //
        // Let's use the combinatorial formula:
        // For 2n items, there are (2n)! total permutations.
        // For each pair (Pi, Di), Pi must come before Di. For any given pair, in half of the
        // permutations Pi comes before Di, and in the other half, Di comes before Pi.
        // Since there are n such pairs, and their relative order requirements are independent,
        // the number of valid permutations is (2n)! / (2^n).
        //
        // Now, let's derive the recurrence relation from this formula:
        // f(n) = (2n)! / 2^n
        // f(n-1) = (2(n-1))! / 2^(n-1)
        //
        // f(n) / f(n-1) = [(2n)! / 2^n] / [(2n-2)! / 2^(n-1)]
        // f(n) / f(n-1) = (2n)! / (2n-2)! * 2^(n-1) / 2^n
        // f(n) / f(n-1) = (2n * (2n-1) * (2n-2)!) / (2n-2)! * (1/2)
        // f(n) / f(n-1) = 2n * (2n-1) * (1/2)
        // f(n) / f(n-1) = n * (2n-1)
        //
        // So, the recurrence relation is f(n) = f(n-1) * n * (2n-1).
        // We need to calculate this modulo 10^9 + 7.

        for i in 1..=n {
            // Multiply by 'i' (for the 'n' part of the recurrence)
            ans = (ans * i) % modulo;
            // Multiply by '(2*i - 1)' (for the '2n-1' part of the recurrence)
            ans = (ans * (2 * i - 1)) % modulo;
        }

        ans as i32
    }
}
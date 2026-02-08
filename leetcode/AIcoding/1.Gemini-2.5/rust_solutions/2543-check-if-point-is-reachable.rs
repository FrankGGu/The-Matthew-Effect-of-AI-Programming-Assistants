impl Solution {
    pub fn is_reachable(target_x: i32, target_y: i32) -> bool {
        // Helper function to calculate GCD (Greatest Common Divisor)
        // using the Euclidean algorithm.
        fn gcd(mut a: i32, mut b: i32) -> i32 {
            while b != 0 {
                let temp = b;
                b = a % b;
                a = temp;
            }
            a
        }

        // Calculate the greatest common divisor of targetX and targetY.
        let common_divisor = gcd(target_x, target_y);

        // The core idea is that the operations (x+y, y), (x, x+y), (x/2, y), (x, y/2)
        // can only change the GCD in specific ways:
        // 1. (x+y, y) and (x, x+y) preserve the GCD: gcd(x+y, y) = gcd(x, y).
        // 2. (x/2, y) and (x, y/2) can either preserve the GCD or divide it by 2.
        //    Specifically, if gcd(x, y) = G:
        //    - If x is even, y is odd: gcd(x/2, y) = G.
        //    - If x is odd, y is even: gcd(x, y/2) = G.
        //    - If x is even, y is even: gcd(x/2, y) can be G or G/2.
        //      It will be G if x has an odd factor that y doesn't, and x has more factors of 2 than y.
        //      It will be G/2 if x and y have the same number of factors of 2.
        //
        // In any case, the GCD of the coordinates can never gain an odd prime factor.
        // Since we start at (1, 1) and gcd(1, 1) = 1 (which has no odd prime factors other than 1),
        // any reachable point (x, y) must have gcd(x, y) as a power of 2.
        //
        // Conversely, if gcd(targetX, targetY) = G is a power of 2,
        // let targetX = G * x' and targetY = G * y', where gcd(x', y') = 1.
        // We can reach (x', y') from (1, 1) using only (x+y, y) and (x, x+y) operations (or their reverse,
        // which is the Euclidean algorithm's subtraction steps).
        // Once at (x', y'), we can use the reverse of the division operations (multiplication by 2)
        // to multiply both x' and y' by G (since G is a power of 2).
        // For example, to get (G*x', G*y'), we can apply (2x, y) G times to x' and (x, 2y) G times to y'.
        // This means we can reach (targetX, targetY).
        //
        // Therefore, the condition for reachability is that gcd(targetX, targetY) must be a power of 2.
        // A positive integer 'n' is a power of 2 if and only if n > 0 and (n & (n - 1)) == 0.
        // Since targetX and targetY are positive, common_divisor will also be positive.
        common_divisor > 0 && (common_divisor & (common_divisor - 1)) == 0
    }
}
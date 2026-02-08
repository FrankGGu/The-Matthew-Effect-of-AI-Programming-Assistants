impl Solution {
    pub fn smallest_repunit_div_by_k(k: i32) -> i32 {
        if k % 2 == 0 || k % 5 == 0 {
            return -1;
        }

        let mut remainder = 0;
        for length in 1..=k {
            remainder = (remainder * 10 + 1) % k;
            if remainder == 0 {
                return length;
            }
        }

        // This part of the code should theoretically not be reached because if k is not
        // divisible by 2 or 5, a solution is guaranteed to exist within k iterations
        // due to properties of modular arithmetic.
        // However, to satisfy Rust's type system that all paths must return a value,
        // or if there's an unexpected edge case not covered by the mathematical proof,
        // we can add a panic or an unreachable!() macro.
        // For LeetCode, typically, if the problem guarantees a return, this isn't strictly needed.
        // But if the compiler insists, unreachable!() is the idiomatic way.
        unreachable!()
    }
}
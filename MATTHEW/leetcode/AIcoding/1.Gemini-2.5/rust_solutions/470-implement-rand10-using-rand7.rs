impl Solution {
    #[allow(non_snake_case)]
    pub fn rand10() -> i32 {
        loop {
            // Generate a number in the range [1, 49] with uniform probability.
            // (rand7() - 1) * 7 generates numbers 0, 7, 14, 21, 28, 35, 42.
            // Adding rand7() (which is 1-7) to this shifts the range.
            // Smallest: (1 - 1) * 7 + 1 = 1
            // Largest: (7 - 1) * 7 + 7 = 42 + 7 = 49
            let val = (rand7() - 1) * 7 + rand7();

            // We want numbers from 1 to 10.
            // The range [1, 40] is a multiple of 10 (4 * 10).
            // If val is in [1, 40], we can map it to [1, 10].
            if val <= 40 {
                // (val - 1) % 10 + 1 maps:
                // 1-10 -> 1-10
                // 11-20 -> 1-10
                // 21-30 -> 1-10
                // 31-40 -> 1-10
                // Each number from 1 to 10 appears exactly 4 times in the range [1, 40],
                // ensuring uniform probability.
                return (val - 1) % 10 + 1;
            }
            // If val is in [41, 49], it's outside our desired uniform range [1, 40].
            // We reject these values and retry the process to maintain uniformity.
        }
    }
}
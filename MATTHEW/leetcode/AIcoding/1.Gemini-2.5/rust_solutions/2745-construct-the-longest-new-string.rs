impl Solution {
    pub fn longest_string(x: i32, y: i32, z: i32) -> i32 {
        let x_long = x as i64;
        let y_long = y as i64;
        let z_long = z as i64;

        // The 'AB' blocks are very flexible. They can be inserted anywhere without creating "AAA" or "BBB".
        // For example, "AA" + "AB" + "AA" results in "AAABAA", which is valid.
        // This means that 'z' "AB" blocks can effectively separate 'z+1' "AA" blocks or 'z+1' "BB" blocks.
        //
        // Therefore, the maximum number of "AA" blocks we can use is limited by 'x' itself,
        // and also by the number of "AB" blocks available to separate them if 'x' is large.
        // Specifically, we can use at most `z + 1` "AA" blocks (e.g., AA AB AA AB ... AA).
        // So, the actual number of "AA" blocks we can use is `min(x, z + 1)`.
        //
        // Similarly, the maximum number of "BB" blocks we can use is `min(y, z + 1)`.
        //
        // All 'z' "AB" blocks can always be used, as they don't violate the "AAA" or "BBB" rule.
        //
        // The total number of blocks used will be the sum of these maximum usable counts.
        // Each block ("AA", "BB", or "AB") has a length of 2.
        // So, the total length is `(count_AA_used + count_BB_used + count_AB_used) * 2`.

        let count_aa_used = x_long.min(z_long + 1);
        let count_bb_used = y_long.min(z_long + 1);
        let count_ab_used = z_long;

        ((count_aa_used + count_bb_used + count_ab_used) * 2) as i32
    }
}
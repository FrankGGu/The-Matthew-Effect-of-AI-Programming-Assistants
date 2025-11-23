impl Solution {
    pub fn min_changes(n: i32, k: i32) -> i32 {
        let n_u = n as u32;
        let k_u = k as u32;

        // If any bit is set in k but not in n, it's impossible to make n equal to k
        // by only changing 1s to 0s in n (as implied by the problem's examples/explanation).
        // This condition is equivalent to checking if k is a "submask" of n.
        // If (n_u & k_u) != k_u, it means there's at least one bit position where k_u has a 1
        // but n_u has a 0. In this scenario, we would need to change a 0 in n_u to a 1,
        // which is considered impossible according to the problem's implicit rules.
        if (n_u & k_u) != k_u {
            return -1;
        }

        // If it's possible, we need to count the number of bits that are 1 in n_u
        // but 0 in k_u. These are the bits that must be changed from 1 to 0.
        // The XOR operation (n_u ^ k_u) will have a 1 at every bit position where n_u
        // and k_u differ.
        // Since we've already established that k_u cannot have a 1 where n_u has a 0,
        // all the 1s in (n_u ^ k_u) must correspond to positions where n_u has a 1
        // and k_u has a 0.
        (n_u ^ k_u).count_ones() as i32
    }
}
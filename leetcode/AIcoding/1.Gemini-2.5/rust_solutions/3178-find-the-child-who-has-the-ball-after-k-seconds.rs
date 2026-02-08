impl Solution {
    pub fn find_the_child(n: i32, k: i32) -> i32 {
        if n == 1 {
            return 0;
        }

        let cycle_len = 2 * (n - 1);
        let k_effective = k % cycle_len;

        if k_effective < n {
            k_effective
        } else {
            // The ball is moving backwards from n-1
            // k_effective = n corresponds to child n-2
            // k_effective = n+1 corresponds to child n-3
            // ...
            // k_effective = n-1 + x, child is (n-1) - x
            // x = k_effective - (n-1)
            // child = (n-1) - (k_effective - (n-1))
            // child = 2 * (n-1) - k_effective
            2 * (n - 1) - k_effective
        }
    }
}
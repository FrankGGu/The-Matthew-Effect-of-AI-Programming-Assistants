impl Solution {
    pub fn beautiful_towers(a: Vec<i32>, k: i32) -> i32 {
        let mut a = a;
        a.sort_unstable();
        let n = a.len();
        let mut max_tower_height = 1;

        for i in 1..n {
            if a[i] - a[i - 1] <= k {
                max_tower_height += 1;
            } else {
                max_tower_height = 1;
            }
        }

        max_tower_height
    }
}
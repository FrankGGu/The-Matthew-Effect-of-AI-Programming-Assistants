impl Solution {
    pub fn sort_even_odd(nums: Vec<i32>) -> Vec<i32> {
        let mut even: Vec<i32> = nums.iter().enumerate().filter(|(i, _)| i % 2 == 0).map(|(_, &x)| x).collect();
        let mut odd: Vec<i32> = nums.iter().enumerate().filter(|(i, _)| i % 2 != 0).map(|(_, &x)| x).collect();

        even.sort_unstable();
        odd.sort_unstable_by(|a, b| b.cmp(a));

        let mut res = Vec::with_capacity(nums.len());
        let mut e = 0;
        let mut o = 0;

        for i in 0..nums.len() {
            if i % 2 == 0 {
                res.push(even[e]);
                e += 1;
            } else {
                res.push(odd[o]);
                o += 1;
            }
        }

        res
    }
}
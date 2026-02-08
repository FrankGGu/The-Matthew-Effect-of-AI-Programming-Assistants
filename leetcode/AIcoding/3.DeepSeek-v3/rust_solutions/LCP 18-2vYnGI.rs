impl Solution {
    pub fn breakfast_number(staple: Vec<i32>, drinks: Vec<i32>, x: i32) -> i32 {
        let mut staple = staple;
        let mut drinks = drinks;
        staple.sort();
        drinks.sort();
        let mut res = 0;
        let m = staple.len();
        let n = drinks.len();
        let mut j = n as i32 - 1;
        for i in 0..m {
            while j >= 0 && staple[i] + drinks[j as usize] > x {
                j -= 1;
            }
            res += j + 1;
            res %= 1000000007;
        }
        res
    }
}
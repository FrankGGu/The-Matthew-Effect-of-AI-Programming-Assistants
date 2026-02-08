impl Solution {
    pub fn breakfast_number(staple: Vec<i32>, drinks: Vec<i32>, x: i32) -> i32 {
        let mut staple = staple;
        let mut drinks = drinks;
        staple.sort();
        drinks.sort();
        let mut count = 0;
        let mut j = drinks.len() - 1;
        for i in 0..staple.len() {
            while j >= 0 && staple[i] + drinks[j] > x {
                j -= 1;
            }
            if j >= 0 {
                count = (count + j as i32 + 1) % 1000000007;
            } else {
                break;
            }
        }
        count
    }
}
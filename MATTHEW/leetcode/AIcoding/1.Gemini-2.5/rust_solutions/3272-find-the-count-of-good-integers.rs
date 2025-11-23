impl Solution {
    pub fn find_the_count_of_good_integers(n: i32) -> i32 {
        let mut count = 0;
        for i in 1..=n {
            if i % 3 == 0 {
                count += 1;
            }
        }
        count
    }
}
impl Solution {
    pub fn max_number_of_groups(d: i32) -> i32 {
        let mut total = 0;
        let mut groups = 0;
        let mut i = 1;

        while total + i <= d {
            total += i;
            groups += 1;
            i += 1;
        }

        groups
    }
}
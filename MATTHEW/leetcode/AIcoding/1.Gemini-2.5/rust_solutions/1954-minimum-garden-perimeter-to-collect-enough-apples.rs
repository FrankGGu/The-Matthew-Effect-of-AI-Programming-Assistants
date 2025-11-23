impl Solution {
    pub fn minimum_perimeter(needed_apples: i64) -> i64 {
        let mut l: i64 = 0;
        let mut current_apples: i64 = 0;

        while current_apples < needed_apples {
            l += 1;
            current_apples = 2 * (2 * l + 1) * l * (l + 1);
        }

        8 * l
    }
}
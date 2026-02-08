impl Solution {
    pub fn min_increment_for_unique(a: Vec<i32>) -> i32 {
        let mut a = a;
        a.sort();
        let mut moves = 0;
        let mut next = 0;

        for &num in &a {
            if num < next {
                moves += next - num;
            }
            next = next.max(num + 1);
        }

        moves
    }
}
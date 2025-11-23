impl Solution {
    pub fn num_moves_stones(a: i32, b: i32, c: i32) -> Vec<i32> {
        let mut arr = vec![a, b, c];
        arr.sort();
        let a = arr[0];
        let b = arr[1];
        let c = arr[2];

        let max_moves = c - a - 2;
        let min_moves = if b - a == 1 && c - b == 1 {
            0
        } else if b - a <= 2 || c - b <= 2 {
            1
        } else {
            2
        };

        vec![min_moves, max_moves]
    }
}
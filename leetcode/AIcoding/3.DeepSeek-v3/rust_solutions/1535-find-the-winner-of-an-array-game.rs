impl Solution {
    pub fn get_winner(arr: Vec<i32>, k: i32) -> i32 {
        let mut current_winner = arr[0];
        let mut win_count = 0;

        for &num in arr.iter().skip(1) {
            if num > current_winner {
                current_winner = num;
                win_count = 1;
            } else {
                win_count += 1;
            }

            if win_count == k {
                break;
            }
        }

        current_winner
    }
}
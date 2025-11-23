impl Solution {
    pub fn get_winner(arr: Vec<i32>, k: i32) -> i32 {
        let n = arr.len();
        if k >= n as i32 - 1 {
            return *arr.iter().max().unwrap();
        }
        let mut winner = arr[0];
        let mut win_count = 0;
        for i in 1..n {
            if winner > arr[i] {
                win_count += 1;
            } else {
                winner = arr[i];
                win_count = 1;
            }
            if win_count == k {
                return winner;
            }
        }
        winner
    }
}
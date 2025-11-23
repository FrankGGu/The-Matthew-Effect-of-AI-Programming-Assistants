impl Solution {
    pub fn get_winner(arr: Vec<i32>, k: i32) -> i32 {
        let n = arr.len();

        if k as usize >= n - 1 {
            return *arr.iter().max().unwrap();
        }

        let mut current_winner = arr[0];
        let mut consecutive_wins = 0;

        for i in 1..n {
            let opponent = arr[i];
            if current_winner > opponent {
                consecutive_wins += 1;
            } else {
                current_winner = opponent;
                consecutive_wins = 1;
            }

            if consecutive_wins == k {
                return current_winner;
            }
        }

        current_winner
    }
}
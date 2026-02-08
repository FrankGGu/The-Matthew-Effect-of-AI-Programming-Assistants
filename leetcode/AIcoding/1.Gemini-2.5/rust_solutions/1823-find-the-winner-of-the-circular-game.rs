struct Solution;

impl Solution {
    pub fn find_the_winner(n: i32, k: i32) -> i32 {
        let mut friends: Vec<i32> = (1..=n).collect();
        let mut current_idx: usize = 0;

        while friends.len() > 1 {
            let num_friends = friends.len();
            let remove_offset = (k - 1) as usize;
            let removed_idx = (current_idx + remove_offset) % num_friends;

            friends.remove(removed_idx);

            current_idx = removed_idx % friends.len();
        }

        friends[0]
    }
}
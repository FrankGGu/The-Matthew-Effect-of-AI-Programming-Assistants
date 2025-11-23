impl Solution {
    pub fn find_the_winner(n: i32, k: i32) -> i32 {
        let mut friends: Vec<i32> = (1..=n).collect();
        let mut index = 0;
        while friends.len() > 1 {
            index = (index + k as usize - 1) % friends.len();
            friends.remove(index);
        }
        friends[0]
    }
}
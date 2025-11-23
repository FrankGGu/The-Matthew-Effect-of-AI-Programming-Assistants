use std::collections::HashSet;

impl Solution {
    pub fn circular_game_losers(n: i32, k: i32) -> Vec<i32> {
        // Use a HashSet to track friends who have received the ball.
        // Friend numbers are 1-indexed as per the problem description.
        let mut received_friends: HashSet<i32> = HashSet::new();

        // The game starts with friend 1 holding the ball.
        let mut current_friend_num = 1;
        received_friends.insert(current_friend_num);

        loop {
            // Calculate the next friend's number.
            // The formula (current_friend_num + k - 1) % n + 1 correctly handles
            // k steps clockwise for 1-indexed friend numbers.
            let next_friend_num = (current_friend_num + k - 1) % n + 1;

            // Check if the next friend has already received the ball.
            if received_friends.contains(&next_friend_num) {
                // If the ball is passed to a friend who already had it, that friend is eliminated,
                // and the game ends.
                break;
            } else {
                // If the friend has not received the ball yet, mark them as received
                // and continue the game with this friend as the current holder.
                received_friends.insert(next_friend_num);
                current_friend_num = next_friend_num;
            }
        }

        // Collect the numbers of friends who are not eliminated.
        // These are the friends who never received the ball.
        let mut losers = Vec::new();
        for i in 1..=n {
            if !received_friends.contains(&i) {
                losers.push(i);
            }
        }

        // The problem asks for a sorted list. Iterating from 1 to n ensures the numbers
        // are added to the `losers` vector in ascending order, so no explicit sort is needed.
        losers
    }
}
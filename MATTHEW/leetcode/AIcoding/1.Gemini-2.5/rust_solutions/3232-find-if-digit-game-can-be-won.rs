struct Solution;

impl Solution {
    pub fn can_alice_win(nums: Vec<i32>) -> bool {
        let mut nums = nums;
        nums.sort_unstable(); // Sorts in ascending order

        let n = nums.len();
        let mut alice_score = 0;
        let mut bob_score = 0;

        // Players take turns picking the largest available digit.
        // Since nums is sorted ascending, we iterate from the end to get largest digits.
        // Alice goes first, so she gets the largest, then Bob gets the second largest, etc.
        for i in 0..n {
            let digit = nums[n - 1 - i]; // Get digits in descending order
            if i % 2 == 0 { // Alice's turn (0th largest, 2nd largest, ...)
                alice_score += digit;
            } else { // Bob's turn (1st largest, 3rd largest, ...)
                bob_score += digit;
            }
        }

        alice_score > bob_score
    }
}
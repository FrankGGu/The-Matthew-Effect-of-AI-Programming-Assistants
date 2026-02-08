impl Solution {
    pub fn sum_game(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut alice_sum = 0;
        let mut bob_sum = 0;
        let mut alice_q = 0;
        let mut bob_q = 0;

        for i in 0..n / 2 {
            if nums[i] == -1 {
                alice_q += 1;
            } else {
                alice_sum += nums[i];
            }
        }

        for i in n / 2..n {
            if nums[i] == -1 {
                bob_q += 1;
            } else {
                bob_sum += nums[i];
            }
        }

        if (alice_q + bob_q) % 2 != 0 {
            return true;
        }

        let q_diff = alice_q - bob_q;
        let sum_diff = bob_sum - alice_sum;

        if q_diff / 2 * 9 == sum_diff {
            return false;
        }

        return true;
    }
}
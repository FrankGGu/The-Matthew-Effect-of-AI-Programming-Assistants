impl Solution {
    pub fn num_steps(s: String) -> i32 {
        let mut steps = 0;
        let mut carry = 0; // Represents a carry-over from adding 1
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();

        // Iterate from the least significant bit (index n-1) up to the second most significant bit (index 1).
        // The most significant bit (index 0) is handled separately after the loop.
        for i in (1..n).rev() {
            let bit_val = chars[i].to_digit(10).unwrap();
            let effective_sum = bit_val + carry;

            if effective_sum % 2 == 1 { // If the current effective bit is 1, the number is odd
                // Operation: Add 1. This takes 1 step.
                // After adding 1, the number becomes even.
                // Operation: Divide by 2. This takes another 1 step.
                // So, for an odd number, it takes 2 steps in total for this bit.
                steps += 2;
                carry = 1; // Adding 1 to an odd number (ending in ...1) results in ...0 with a carry to the left.
            } else { // If the current effective bit is 0, the number is even
                // Operation: Divide by 2. This takes 1 step.
                steps += 1;
                // If effective_sum was 0 (bit_val=0, carry=0), carry remains 0.
                // If effective_sum was 2 (bit_val=1, carry=1), adding 1 (conceptually) would make it ...10,
                // then dividing by 2 would remove the 0, leaving a 1 as carry.
                // So, carry = effective_sum / 2 correctly captures this.
                carry = effective_sum / 2;
            }
        }

        // After the loop, we are left with the most significant bit (s[0]) and the final carry.
        // The number is effectively (s[0] + carry) in binary.
        // Since s[0] is guaranteed to be '1', this value will be either 1 or 2.
        let final_msb_val = chars[0].to_digit(10).unwrap() + carry;

        if final_msb_val == 2 { // If the effective most significant bit is "10" (binary), which is 2 decimal
            steps += 1; // One more step is needed to divide 2 by 2 to get 1.
        }
        // If final_msb_val is 1, the number is already 1, so no more steps are needed.

        steps
    }
}
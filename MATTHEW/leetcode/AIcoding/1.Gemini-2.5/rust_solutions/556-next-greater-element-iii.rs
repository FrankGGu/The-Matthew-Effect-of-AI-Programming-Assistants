impl Solution {
    pub fn next_greater_element(n: i32) -> i32 {
        let mut digits: Vec<char> = n.to_string().chars().collect();
        let len = digits.len();

        // Step 1: Find the largest index k such that digits[k] < digits[k + 1]
        // If no such index exists, the number is in descending order (e.g., 321),
        // so no next greater element is possible.
        let mut k = len as isize - 2;
        while k >= 0 && digits[k as usize] >= digits[(k + 1) as usize] {
            k -= 1;
        }

        if k < 0 {
            return -1;
        }

        // Step 2: Find the largest index l greater than k such that digits[k] < digits[l]
        let mut l = len as isize - 1;
        while l > k && digits[l as usize] <= digits[k as usize] {
            l -= 1;
        }

        // Step 3: Swap digits[k] and digits[l]
        digits.swap(k as usize, l as usize);

        // Step 4: Reverse the sub-array from index k + 1 to the end
        digits[(k as usize + 1)..len].reverse();

        // Step 5: Convert the modified digits back to an integer
        let mut result: i64 = 0; // Use i64 to detect overflow
        for &digit_char in digits.iter() {
            let digit = digit_char.to_digit(10).unwrap();
            result = result * 10 + digit as i64;
            if result > i32::MAX as i64 {
                return -1; // Result exceeds i32::MAX
            }
        }

        result as i32
    }
}
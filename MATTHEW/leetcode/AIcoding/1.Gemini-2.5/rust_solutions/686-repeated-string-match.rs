impl Solution {
    pub fn repeated_string_match(a: String, b: String) -> i32 {
        let n_a = a.len();
        let n_b = b.len();

        // Calculate the minimum number of times 'a' needs to be repeated
        // so that its length is at least as long as 'b'.
        // This is equivalent to ceil(n_b / n_a).
        let mut count = n_b / n_a;
        if n_b % n_a != 0 {
            count += 1;
        }

        // Build the string by repeating 'a' 'count' times.
        // We use String::with_capacity to pre-allocate memory for efficiency.
        let mut temp_a = String::with_capacity(count * n_a + 2 * n_a); // Allocate for count+2 repetitions
        for _ in 0..count {
            temp_a.push_str(&a);
        }

        // Check if 'b' is a substring of the current repeated 'a' string.
        if temp_a.contains(&b) {
            return count as i32;
        }

        // If not found, 'b' might start in the last part of `temp_a` and
        // extend into the next repetition of `a`.
        // So, we append 'a' one more time and increment the count.
        temp_a.push_str(&a);
        count += 1;

        // Check again if 'b' is a substring.
        if temp_a.contains(&b) {
            return count as i32;
        }

        // According to the problem analysis, if 'b' is a substring of any
        // repeated version of 'a', it must be found within 'a' repeated
        // 'count' or 'count + 1' times. If it's not found by now, it's impossible.
        -1
    }
}
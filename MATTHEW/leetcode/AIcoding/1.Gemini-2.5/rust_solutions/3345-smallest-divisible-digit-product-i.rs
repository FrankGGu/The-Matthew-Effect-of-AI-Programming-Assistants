use std::collections::{VecDeque, HashMap};

fn gcd(a: u32, b: u32) -> u32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}

impl Solution {
    pub fn smallest_divisible_digit_product(n: i32) -> String {
        let n_u32 = n as u32;

        if n_u32 == 1 {
            return "1".to_string();
        }

        let mut q: VecDeque<(u32, String)> = VecDeque::new();
        // memo stores the smallest string found so far for a given `current_n` value.
        // `current_n` represents `n` divided by the product of digits in the string.
        let mut memo: HashMap<u32, String> = HashMap::new();

        // Initial state: `n_u32` is the target value to be reduced to 1,
        // and "" is the empty string representing no digits yet.
        q.push_back((n_u32, "".to_string()));
        memo.insert(n_u32, "".to_string());

        while let Some((current_n, current_str)) = q.pop_front() {
            // Iterate through digits 1 to 9 to append to the current string
            for digit in 1..=9 {
                // Calculate the new `current_n` after considering the `digit`
                let new_n = current_n / gcd(current_n, digit);
                let new_str = format!("{}{}", current_str, digit);

                // If `new_n` becomes 1, we have found a number whose digit product
                // is divisible by the original `n`. Since this is a BFS, the first
                // such number found will be the shortest (fewest digits) and
                // lexicographically smallest due to iterating digits 1-9.
                if new_n == 1 {
                    return new_str;
                }

                // Check if this path to `new_n` is better than any previously found path
                let should_update_memo = match memo.get(&new_n) {
                    Some(existing_str) => {
                        // Update if `new_str` is shorter, or same length and lexicographically smaller
                        new_str.len() < existing_str.len() || 
                        (new_str.len() == existing_str.len() && new_str < *existing_str)
                    },
                    None => true, // No existing entry for `new_n`, so this is the first path found
                };

                if should_update_memo {
                    memo.insert(new_n, new_str.clone());
                    q.push_back((new_n, new_str));
                }
            }
        }

        // According to problem constraints and typical LeetCode problem design,
        // a solution is always expected to be found and returned within the loop.
        // If `n` could have prime factors greater than 7, this part might be reached,
        // but for this problem, it's generally assumed `n` will only have prime factors 2, 3, 5, 7.
        unreachable!() 
    }
}
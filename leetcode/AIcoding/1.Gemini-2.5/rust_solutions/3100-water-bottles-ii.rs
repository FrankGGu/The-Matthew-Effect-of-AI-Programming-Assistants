impl Solution {
    pub fn max_bottles_drunk(num_bottles: i32, num_exchange: i32) -> i32 {
        let mut total_drank = num_bottles;
        let mut empty_bottles = num_bottles;
        let mut free_bottle_used = false;

        loop {
            if !free_bottle_used && empty_bottles == num_exchange - 1 {
                total_drank += 1;
                empty_bottles += 1;
                free_bottle_used = true;
                continue;
            }

            if empty_bottles >= num_exchange {
                let new_full_bottles = empty_bottles / num_exchange;
                total_drank += new_full_bottles;
                empty_bottles = empty_bottles % num_exchange + new_full_bottles;
                continue;
            }

            break;
        }

        total_drank
    }
}